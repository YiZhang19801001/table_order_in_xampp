/**
 * Created by jesse on 2018/1/18.
 */
new Vue
({
    el: '#info',
    data:
    {
        qrcode_url: '',
        isshow: false,
        isqrcode: false,
        info: [],  //店铺信息
        menu: [],  //菜单
        cart: [],  //购物车
        schedule: [],  //时间表
        couponList: [],  //优惠券
        reviews: [],  //评论
        price: {},
        selected: '',
        dates: [],
        dateed: {},
        timeed: 'Select time...',
        selected_id: 0,
        ext: null,
        cartl: 0,
        coupon: null,
        extid: {},
        specials: //优惠
        {
            show: true,
            taggle: false,
        },
        star:  //星星
        {
            neatly: 0,
            remaining: 0
        },
        delivery: [],  //运输方式
        nav: false,
        cartShow: false,
        areaShow: false,
        backdrop: false,  //遮罩层
        moreInfo: false,  //更多信息
        login: false,  //登录
        reg: false,
        orderSelect: false,  //订单方式
        dateShow: false,  //日期选择
        timeShow: false,  //时间选择
        reviewsShow: false,  //评论
        asidShow: false
    },
    created: function ()
    {
        var _this = this;
        var viewId = location.search.split('location_id=')[1];

        $.post
        (
            '/index.php?route=shop/info/ajaxReturn',
            {
                location_id: viewId
            },
            function(data)
            {
                _this.menu = data.shopList;  //菜单
                _this.info = data.shopInfo;  //商品信息
                _this.cart = data.cart  //范围选项
                _this.schedule = data.schedule; //时间表
                _this.couponList = data.couponList;  //优惠券
                _this.reviews = data.reviews;  //评论
                _this.delivery = data.delivery  //范围选项
                _this.price = data.price  //钱

                _this.isqrcode = data.isqrcode;

                if (data.isqrcode && data.mobile_message) {
                    _this.cart_info = data.mobile_message.product;
                    _this.qrcode_url = '/index.php?route=pay/checkout/qrCode&message=' + data.mobile_message.url_message;
                    _this.isshow = true;
                }

                _this.cartLength(data.cart);
                //star
                _this.star.neatly = parseInt(_this.info.star);  //星星数量
                _this.star.remaining = parseInt(5 - _this.info.star);  //星星剩余数量
                //菜单状态
                for (var i = 0; i < _this.menu.length; i++)
                {
                    _this.$set(_this.menu[i], 'show', false);
                }
                //信息
                for (var i = 0; i < _this.info.shopInfo.length; i++)
                {
                    _this.$set(_this.info.shopInfo[i], 'show', true);
                }
                //时间
                var date = new Date(),
                    invertedNum = date.toString().indexOf(' 201'),
                    week= date.getDay(),
                    when = date.toString().slice(0, invertedNum);
                _this.dateed = {week: week, when: when};
                //选中时间
                if (data.delivery.shipping_orderDate)
                {
                    _this.dateed.when = data.delivery.shipping_orderDate;
                }
                if (data.delivery.shipping_orderTime)
                {
                    _this.timeed = data.delivery.shipping_orderTime;
                }
                //优惠默认选择
                for (var i in data.couponList)
                {
                    if (data.couponList[i].is_click == true) _this.coupon = data.couponList[i].id;
                }
            }
        )
    },
    methods:
    {
        checkout: function () {
            if (this.cartl) {
                if (this.isqrcode) {
                    var _this = this;
                    $.post(
                        '/index.php?route=pay/checkout/mobile',
                        function (data) {
                            if (data.status && data.product) {
                                _this.backdrop = _this.cartShow = false;
                                _this.isshow = true;
                                _this.qrcode_url = '/index.php?route=pay/checkout/qrCode&message=' + data.url_message;
                                _this.cart_info = data.product;
                            } else {
                                _this.isshow = false;
                            }
                        }
                    )
                } else {
                    location.href = "index.php?route=pay/checkout";
                }
            }
        },
        areaFlag: function (flag)
        {
            this.areaShow = flag;
            this.orderSelect = !flag;
        },
        dateFlag: function (flag)
        {
            this.dateShow = flag;
            this.orderSelect = !flag;

            if (flag)
            {
                var date = new Date(),
                    invertedNum = date.toString().indexOf(' 201'),
                    week= date.getDay(),
                    when = date.toString().slice(0, invertedNum);
                this.dates.push({week: week, when: when});
                for (var i = 0; i < 30; i++)
                {
                    date.setDate(date.getDate() + 1);
                    week= date.getDay();
                    when = date.toString().slice(0, invertedNum);
                    this.dates.push({week: week, when: when});
                }
            }
        },
        timeFlag: function (flag)
        {
            if (flag)
            {
                var _this = this;
                $.post
                (
                    '/index.php?route=shop/info/ajaxReturn',
                    {
                        location_id: this.info.location_id,
                        day: this.dateed.week
                    },
                    function(data)
                    {
                        _this.info = data.shopInfo;
                        _this.delivery.areaList = data.delivery.areaList;
                        _this.timeShow = flag;
                        _this.orderSelect = !flag;
                    }
                )
            }
            else
            {
                this.timeShow = flag;
                this.orderSelect = !flag;
            }
        },
        asidFlag: function (flag)
        {
            this.asidShow = flag;
            this.orderSelect = !flag;
        },
        Oselect: function (change)
        {
            var _this = this;

            if (this.delivery.isp == 1 && this.delivery.zone_id == 0)
            {
                this.orderSelect = true;
                this.cartShow = false;
                return;
            }
            //购物车改变
            if(change == 'change')
            {
                this.delivery.isp = this.delivery.isp == 1 ? 2 : 1;
            }

            $.post
            (
                '/index.php?route=shop/info/ajaxReturn',
                {
                    location_id: this.info.location_id,
                    zone_id: this.delivery.zone_id,
                    isp: this.delivery.isp
                },
                function(data)
                {
                    _this.price = data.price;  //价钱信息
                    _this.delivery = data.delivery; //默认选择
                    // _this.couponList = data.couponList;  //与价格相关的优惠
                    // _this.info = data.shopInfo;
                }
            )
        },
        Oselected: function (product_id, ext)
        {
            var length = 0;
            for (var i in ext) length++;

            // 如果没有时间、套餐，则直接请求
            if (this.timeed != 'Select time...' && !length)
            {
                var _this = this,
                    data = {};

                data =
                {
                    location_id: this.info.location_id,
                    isp: this.delivery.isp,
                    zone_id: this.delivery.zone_id,
                    shipping_orderDate: this.dateed.when,
                    shipping_orderTime: this.timeed,
                    product_id: product_id,
                    product_option_id: 0,
                    product_option_value_id: 0,
                    quantity: 1,
                    ext: 0
                };

                $.post
                (
                    '/index.php?route=shop/info/ajaxReturn',data,
                    function (data)
                    {
                        _this.cart = data.cart; //购物车
                        _this.cartLength(data.cart);
                        _this.price = data.price;  //价格
                    }
                )
            }
            else
            {
                //如果时间或者套餐没有选择那么弹出选择框
                this.orderSelect = this.backdrop = true;
                this.selected_id = product_id;
                this.ext = ext;
            }
        },
        refer: function (ev, calc, product_id, extId)
        {
            var _this = this,
                data = {};

            //套餐
            var length = 0,
                extids = [],
                product_ext_id = '';
            if (this.isqrcode) {
                var data = {
                    location_id: this.info.location_id,
                    product_ext_id: product_ext_id,
                    product_id: product_id,
                    product_option_id: 0,
                    product_option_value_id: 0,
                    quantity: calc,
                    ext: 0
                };
            } else {
                for (var i in this.ext) length++;
                for (var i in this.extid)
                {
                    extids.push(this.extid[i]);
                }
                if (typeof extId == 'undefined')
                {
                    product_ext_id = String(extids);
                }
                else
                {
                    product_ext_id = extId.substr(0, extId.length - 1);
                }
                if (length && product_ext_id == '')
                {
                    this.asidFlag(true);
                    return;
                }
                if (this.delivery.isp == 1)
                {
                    if (calc == 1)
                    {
                        if (this.delivery.zone_id == 0)
                        {
                            alert('Select address...');
                            return;
                        }
                        data =
                        {
                            location_id: this.info.location_id,
                            product_ext_id: product_ext_id,
                            isp: this.delivery.isp,
                            zone_id: this.delivery.zone_id,
                            shipping_orderDate: this.dateed.when,
                            shipping_orderTime: this.timeed,
                            product_id: product_id,
                            product_option_id: 0,
                            product_option_value_id: 0,
                            quantity: calc,
                            ext: 0
                        };
                    }
                    else
                    {
                        data =
                        {
                            location_id: this.info.location_id,
                            product_ext_id: product_ext_id,
                            product_id: product_id,
                            product_option_id: 0,
                            product_option_value_id: 0,
                            quantity: calc,
                            ext: 0
                        };
                    }
                }
                if (this.delivery.isp == 2)
                {
                    if (calc == 1)
                    {
                        if (this.timeed == 'Select time...')
                        {
                            alert('Select time...');
                            return;
                        }
                        data =
                        {
                            location_id: this.info.location_id,
                            product_ext_id: product_ext_id,
                            isp: this.delivery.isp,
                            zone_id: this.delivery.zone_id,
                            shipping_orderDate: this.dateed.when,
                            shipping_orderTime: this.timeed,
                            product_id: product_id,
                            product_option_id: 0,
                            product_option_value_id: 0,
                            quantity: 1,
                            ext: 0
                        };
                    }
                    else
                    {
                        data =
                        {
                            location_id: this.info.location_id,
                            product_ext_id: product_ext_id,
                            product_id: product_id,
                            product_option_id: 0,
                            product_option_value_id: 0,
                            quantity: -1,
                            ext: 0
                        };
                    }
                }
            }

            $.post
            (
                '/index.php?route=shop/info/ajaxReturn',data,
                function (data)
                {
                    if (ev.target.id == 'link_submitPreOrderDetails')
                    {
                        _this.orderSelect = _this.backdrop = false;
                    }
                    _this.cart = data.cart; //购物车
                    _this.cartLength(data.cart);
                    _this.price = data.price;  //价格
                    _this.extid = {};
                    $('.check input').attr('checked', null);
                    // _this.couponList = data.couponList;  //与价格相关的优惠
                }
            )
        },
        cartLength: function (cart)
        {
            
            //购物车长度
            var length = 0;
            for(var ever in cart)
            {
                length = length + cart[ever].quantity;
            }
            this.cartl = length;
        },
        bonus: function ()
        {
            var _this = this;
            $.post
            (
                '/index.php?route=shop/info/ajaxReturn',
                {
                    location_id: _this.info.location_id,
                    coupon_id: this.coupon
                },
                function(data)
                {
                    _this.couponList = data.couponList;  //优惠券更新
                    _this.price = data.price; //价格更新
                    _this.info = data.shopInfo;  //信息更新
                }
            )
        },
        Ochange: function (name, value)
        {
            this.extid[name] = value;
        }
    }
})