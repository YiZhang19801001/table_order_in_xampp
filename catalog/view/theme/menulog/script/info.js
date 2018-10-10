new Vue
({
    el: '#app',
    data:
    {
        info: [],  //店铺信息
        menu: [],  //菜单
        price: [],  //价格相关
        delivery: [],  //运输方式
        cart: [],  //购物车
        schedule: [],  //时间表
        couponList: [],  //优惠券
        exposeMask: false,  //遮罩层
        floating_box:  //浮动框框
        {
            isShow: false,
            time: false,
            html: null,
            styleObject:
            {
                top: 0,
                left: 0,
            }
        },
        photos:  //照片
        {
            isShow: false,
            image_show: false,
            image_index: 0,
            image_length: null,  //数量
            image_opacity: null
        },
        info_box:  //运输判断
        {
            select: null,
            time: null,
        },
        star:  //星星
        {
            neatly: 0,
            remaining: 0
        },
        mini: false,  //最小订餐金额
        isFixed: false,  //滚动固定
        isIndex: 0,  //滚动效果
        message: null,
        cartItemsHeight: 0,
        scrollables: 0,
        scrollableIndex: 0,
        bounds: [],
        bg: ''
    },
    mounted: function()
    {
        this.$nextTick(function()
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
                    _this.price = data.price;  //价钱信息
                    _this.info = data.shopInfo;  //商品信息
                    _this.schedule = data.schedule //时间表
                    _this.couponList = data.couponList;  //优惠券
                    _this.menu = data.shopList;  //菜单
                    _this.delivery = data.delivery  //范围选项
                    _this.cart = data.cart;  //购物车
                    _this.bounds = data.bounds;  //优惠券

                    // 自定义
                    _this.star.neatly = parseInt(_this.info.star);  //星星数量
                    _this.star.remaining = parseInt(5 - _this.info.star);  //星星剩余数量
                    _this.photos.image_length = _this.info.photos.length //photos数量

                    if (!_this.info.isopen)  //关店提示
                    {
                        _this.moveIn('', 'notOpen', 'Old Thanh Huong Restaurant', 'This restaurant is currently unavailable for ordering.');
                    }

                    _this.$nextTick(function()
                    {
                        //购物车高度
                        var $height = 0;
                        $('.cartItems .row').each(function(i)
                        {
                            $height += $(this).innerHeight();
                        })
                        _this.cartItemsHeight = $height;

                        var Oh = 0;
                        $('.gradient-wrapper li').each(function ()
                        {
                            Oh += $(this).outerHeight(true);
                        })
                        $('.gradient-wrapper').height($(window).innerHeight() - 132);
                        if (Oh + 132 > $(window).innerHeight())
                        {
                            // $('.course-nav .gradient-wrapper .scroll-top, .course-nav .gradient-wrapper .scroll-bottom').css({'opacity': 1, 'display': 'block'});
                            $('.course-nav .gradient-wrapper .scroll-bottom').css({'opacity': 1, 'display': 'block'});
                        }
                    })

                    _this.bg = 'background:linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), url('+ _this.info.bgimage +')';
                }
            )

            // scroll
            $(window).on('scroll', this.loadMore);
        })
    },
    methods:
    {
        loadMore: function()   //滚动效果
        {
            var top = $(window).scrollTop();
            top > 400 ? this.isFixed = true : this.isFixed = false;

            var currentIndex = null;
            $("#courseList > li").each(function()
            {
                var listTop = $(this).offset().top;
                if (top > listTop - 10)
                {
                    currentIndex = $(this).index();
                } else
                {
                    return false;
                }
            })
            if (currentIndex == null) currentIndex = 0;
            this.isIndex = currentIndex;
        },
        iscrollTop: function(index, type)  //定位效果
        {
            if (type == 'top')
            {
                $('.course-nav-wrapper ul').css('top', '0');
                $('.course-nav-wrapper ul').css('bottom', 'auto');
                $('.course-nav .gradient-wrapper .scroll-bottom').css({'opacity': 1, 'display': 'block'});
                $('.course-nav .gradient-wrapper .scroll-top').css({'opacity': 0, 'display': 'none'});
            }
            else if (type == 'bottom')
            {
                $('.course-nav-wrapper ul').css('top', 'auto');
                $('.course-nav-wrapper ul').css('bottom', '0');
                $('.course-nav .gradient-wrapper .scroll-bottom').css({'opacity': 0, 'display': 'none'});
                $('.course-nav .gradient-wrapper .scroll-top').css({'opacity': 1, 'display': 'block'});
            }
            $("html,body").animate({ scrollTop: $('#course' + index).offset().top }, 300);
        },
        moveIn: function(ev, type, title, info)  //弹框
        {
            var $dom = $(ev.target);
            if (type == 'about')  //公告
            {
                var html = '<div class="popoverTitle">About ' + this.info.name + '</div><span itemprop="description"><p class="noSpaceBelow">' + this.info.aboutUs + '</p></span>';
                var style =
                {
                    top: ($dom.offset().top + $dom.height() + 5) + 'px',
                    left: ($dom.offset().left - $('.core-popover').width() / 2) + 'px',
                    maxWidth: '450px'
                };
            }
            else if (type == 'open')  //时间表
            {
                var schedule = '<div class="schedule"> <div class="scheduleTitle">Delivery Schedule</div><dl>',
                    rightSchedule = '<div class="schedule rightSchedule"> <div class="scheduleTitle">Takeaway Schedule</div><dl>',
                    bottomSchedule = '<div class="schedule bottomSchedule"> <div class="scheduleTitle">Unavailable Dates</div> <ul>';

                schedule += dlHtml(this.schedule.delivery);
                rightSchedule += dlHtml(this.schedule.takeaway);

                for (var i in this.schedule.unavailable)
                {
                    bottomSchedule += '<li>'+ this.schedule.unavailable[i] +'</li>';
                }
                if (typeof this.schedule.unavailable == 'undefined')  bottomSchedule = '';

                    var html = '<div class="popoverTitle">' + this.info.name + ' Schedule</div>' + schedule + rightSchedule + '<div class="contentEnd"></div>' + bottomSchedule;
                var style =
                {
                    top: ($dom.offset().top + $dom.height() + 5) + 'px',
                    left: ($dom.offset().left - $('.core-popover').width() / 2) + 'px',
                    maxWdith: '600px'
                };
            }
            else if (type == 'coupon')  //优惠券
            {
                var html = '<div class="popoverTitle" itemprop="name">' + title + '</div><span itemprop="description"> <p class="noSpaceBelow">' + info + '</p> </span>';
                var style =
                {
                    top: ($dom.offset().top + $dom.height() + 5) + 'px',
                    left: ($dom.offset().left - $('.core-popover').width() / 2) + 60 + 'px',
                    maxWidth: '300px'
                };
            }
            else if (type == 'notOpen')  //关店
            {
                var html = '<div class="popoverTitle" itemprop="name">' + title + '</div><span itemprop="description"> <p class="noSpaceBelow">' + info + '</p> </span>';
                this.exposeMask = true;
                var style =
                {
                    position: 'fixed',
                    width: '600px',
                    top: '50%',
                    left: '50%',
                    transform: 'translate(-50%, -50%)'
                };
            }
            else if (type == 'text')  //底部提示
            {
                var html = 'If you have a Menulog voucher code, enter it in the voucher field at the end of the checkout process.';

                var style =
                {
                    top: $dom.offset().top - 120 + 'px',
                    left: ($dom.offset().left - $('.core-popover').width() / 2) + 100 + 'px',
                    maxWidth: '200px'
                };
            }
            else if (type == 'less')  //去除购物车
            {
                var html = '<p class="core-spaceForCloseX core-last">Are you sure you want to remove this item from your order?</p><div class="core-dialogueButtons"><div><button type="submit" class="confirm">Yes</button><button type="submit" class="cancel">No</button></div></div>';
                this.exposeMask = true;
                var style =
                {
                    position: 'fixed',
                    width: '335px',
                    top: '50%',
                    left: '50%',
                    transform: 'translate(-50%, -50%)'
                };

                this.$nextTick(function()
                {
                    var _this = this;
                    $('.confirm').off().on('click', function ()
                    {
                        $.post
                        (
                            '/index.php?route=shop/info/ajaxReturn', title,
                            function(data)
                            {
                                _this.cart = data.cart; //购物车
                                _this.price = data.price;  //价格
                                _this.floating_box.isShow = _this.exposeMask = false;
                                _this.couponList = data.couponList;  //与价格相关的优惠


                                _this.$nextTick(function()
                                {
                                    // 动画特效
                                    var $height = 0;
                                    $('.cartItems .row').each(function(i)
                                    {
                                        $height += $(this).innerHeight();
                                    })
                                    _this.cartItemsHeight = $height;
                                })
                            }
                        )
                    })
                    $('.cancel').off().on('click', function ()
                    {
                        _this.floating_box.isShow = _this.exposeMask = false;
                    })
                })
            }
            else if (type == 'plus')  //添加购物车
            {
                var html = title;
                var style =
                {
                    top: $dom.offset().top + 'px',
                    left: $('.foodItem').offset().left + $('.foodItem').width() + 40 + 'px'
                };
            }
            else if (type == 'notCart')  //购物车无商品
            {
                var html = '<p class="center core-first core-spaceForCloseX core-last" style="margin: 0; font-size: 20px">Please add some items to your cart before checking out</p>';
                this.exposeMask = true;
                var style =
                {
                    position: 'fixed',
                    top: '50%',
                    left: '50%',
                    transform: 'translate(-50%, -50%)',
                    maxWidth: '675px'
                };
            }
            else if (type == 'select')  //无选择
            {
                var html = '<p class="center core-first core-spaceForCloseX core-last" style="margin: 0; font-size: 20px">Please select a suburb before checking out</p>';
                this.exposeMask = true;
                var style =
                {
                    position: 'fixed',
                    top: '50%',
                    left: '50%',
                    transform: 'translate(-50%, -50%)',
                    maxWidth: '675px'
                };
            }
            else if (type == 'notPrice')  //没有买满最低金额
            {
                var html = '<div class="core-contentBox"><h2>The minimum order amount is '+ this.price.consume +'<sup>*</sup></h2>The total of your selected items is <strong>'+ this.price.productPrice +'</strong> <br><div class="minimumOrderMessagePrompt">   <div class="minimumOrderMessageOrLine"></div>   <div class="minimumOrderMessageOr">OR</div>   <p class="minimumOrderMessagePromptLeft" style="width: 26%;"><a href="/" class="close">Choose more items</a>   </p><form action="/index.php?route=pay/checkout" method="post" style="display: inline-block;       width: 242px;"><p class="minimumOrderMessagePromptRight"><input type="hidden" name="location_id" value="'+ this.info.location_id +'"><button type="submit" style="background: #fff;color: #797876;text-decoration: underline;font-size: 14px;    width: 248px;">Just charge me an extra '+ this.price.remainPrice +'</button></p></form></div><p class="conditions smallSpaceBelow"><sup>*</sup>Calculated after discount but before delivery fees, if any</p></div>';
                this.exposeMask = this.mini = true;
                var style =
                {
                    position: 'fixed',
                    top: '50%',
                    left: '50%',
                    transform: 'translate(-50%, -50%)',
                    maxWidth: '600px',
                };
                this.$nextTick(function()
                {
                    var _this = this;
                    if (!this.delivery.zone_id && this.delivery.isp == 1)
                    {
                        $('.minimumOrderMessagePromptRight button').click(function()
                        {
                            _this.moveIn('', 'select');
                            return false;
                        })
                    }
                })
            }
            else if (type == 'img')  //弹出图片
            {
                var html = '<img src="'+ title +'" />';
                this.exposeMask = true;
                var style =
                {
                    position: 'fixed',
                    top: '50%',
                    left: '50%',
                    transform: 'translate(-50%, -50%)',
                };
            }
            else if (type == 'seasoning')  //调味
            {
                var tm = '';
                var index = 0;

                for (var i in title)
                {
                    index += 10;

                    if (Number(title[i].required))
                    {
                        tm += '<div class="optionGroup" required1="'+ index +'"><h5>'+ i +'</h5><div id="error'+ index +'" class="message" style="display: none"><span class="error">Please choose an option</span></div><ul class="columnize columns-3">'

                        for (var j in title[i].exts)
                        {
                            index += 1;

                            if (Number(title[i].checkbox))
                            {
                                if (Number(title[i].type))
                                {
                                    tm += '<li><input id="option'+ index +'" name="'+ i +'" type="checkbox" value="'+ title[i].exts[j].product_ext_id +'" class="core-ignoreTransformInput checkbox"> ' +
                                        '<label for="option'+ index +'" class="checkbox"><span class="optionName">'+ title[i].exts[j].name +'</span><span class="optionPrice">'+ title[i].exts[j].price +'</span></label></li>';
                                }
                                else
                                {
                                    tm += '<li><input id="option'+ index +'" name="'+ i +'" type="checkbox" value="'+ title[i].exts[j].product_ext_id +'" class="core-ignoreTransformInput checkbox"> ' +
                                        '<label for="option'+ index +'" class="checkbox"><span class="optionName">'+ title[i].exts[j].name +'</span></label></li>';
                                }
                            }
                            else
                            {
                                if (Number(title[i].type))
                                {
                                    tm += '<li><input id="option'+ index +'" name="'+ i +'" type="radio" value="'+ title[i].exts[j].product_ext_id +'" class="core-ignoreTransformInput checkbox"> ' +
                                        '<label for="option'+ index +'" class="checkbox"><span class="optionName">'+ title[i].exts[j].name +'</span><span class="optionPrice">'+ title[i].exts[j].price +'</span></label></li>';
                                }
                                else
                                {
                                    tm += '<li><input id="option'+ index +'" name="'+ i +'" type="radio" value="'+ title[i].exts[j].product_ext_id +'" class="core-ignoreTransformInput checkbox"> ' +
                                        '<label for="option'+ index +'" class="checkbox"><span class="optionName">'+ title[i].exts[j].name +'</span></label></li>';
                                }
                            }
                        }
                    }
                    else
                    {
                        tm += '<div class="optionGroup"><h5>'+ i +'</h5><ul class="columnize columns-3">'

                        for (var j in title[i].exts)
                        {
                            index += 1;

                            if (Number(title[i].checkbox))
                            {
                                if (Number(title[i].type))
                                {
                                    tm += '<li><input id="option'+ index +'" name="'+ i +'" type="checkbox" value="'+ title[i].exts[j].product_ext_id +'" class="core-ignoreTransformInput checkbox"> ' +
                                        '<label for="option'+ index +'" class="checkbox"><span class="optionName">'+ title[i].exts[j].name +'</span><span class="optionPrice">'+ title[i].exts[j].price +'</span></label></li>';
                                }
                                else
                                {
                                    tm += '<li><input id="option'+ index +'" name="'+ i +'" type="checkbox" value="'+ title[i].exts[j].product_ext_id +'" class="core-ignoreTransformInput checkbox"> ' +
                                        '<label for="option'+ index +'" class="checkbox"><span class="optionName">'+ title[i].exts[j].name +'</span></label></li>';
                                }
                            }
                            else
                            {
                                if (Number(title[i].type))
                                {
                                    tm += '<li><input id="option'+ index +'" name="'+ i +'" type="radio" value="'+ title[i].exts[j].product_ext_id +'" class="core-ignoreTransformInput checkbox"> ' +
                                        '<label for="option'+ index +'" class="checkbox"><span class="optionName">'+ title[i].exts[j].name +'</span><span class="optionPrice">'+ title[i].exts[j].price +'</span></label></li>';
                                }
                                else
                                {
                                    tm += '<li><input id="option'+ index +'" name="'+ i +'" type="radio" value="'+ title[i].exts[j].product_ext_id +'" class="core-ignoreTransformInput checkbox"> ' +
                                        '<label for="option'+ index +'" class="checkbox"><span class="optionName">'+ title[i].exts[j].name +'</span></label></li>';
                                }
                            }
                        }
                    }
                    tm += '</ul></div>';
                }

                var html = '<div class="core-titleBox ui-draggable-handle core-popoverDraggable">Make your choice</div>' +
                    '<div class="core_ifhBlock">' +
                    '<form action="#" method="post" id="seasoning" class="takeawayShoppingCartOptions core-ajaxForm">' +
                    '<fieldset>' + tm +
                    '<div class="core-dialogueButtons">' +
                    '<div class="core-left"><button type="submit">Continue</button></div></div>' +
                    '</fieldset></form></div>';
                this.exposeMask = true;
                var style =
                {
                    position: 'fixed',
                    top: '50%',
                    left: '50%',
                    transform: 'translate(-50%, -50%)',
                    maxWidth: '700px'
                };

                this.$nextTick(function()
                {
                    var _this = this;
                    $('#seasoning').off().submit(function ()
                    {
                        event.preventDefault();

                        var onoff = true;
                        $('.optionGroup[required1]').each(function ()
                        {
                            if (!$(this).find('input:checked').length)
                            {
                                $(this).find('#error'+ $(this).attr('required1') +'').show();
                                onoff = false;
                            }
                            else
                            {
                                $(this).find('#error'+ $(this).attr('required1') +'').hide();
                            }
                        })
                        if (!onoff) return;

                        var checked = [];
                        $(".optionGroup input:checked").each(function ()
                        {
                            checked += $(this).attr('value') + ',';
                        })
                        checked = checked.length ? checked.replace(/,$/,"") : 0;

                        $.post
                        (
                            '/index.php?route=shop/info/ajaxReturn',
                            {
                                location_id: _this.info.location_id,
                                product_ext_id: checked,
                                product_id: info.product_id,
                                product_option_id: info.product_option_id,
                                product_option_value_id: info.product_option_value_id,
                                ext: 0  //必须存在
                            },
                            function(data)
                            {
                                _this.cart = data.cart;  //购物车
                                _this.price = data.price;  //价格
                                _this.couponList = data.couponList;  //与价格相关的优惠
                                _this.floating_box.isShow = _this.exposeMask = false;

                                _this.$nextTick(function()
                                {
                                    var $row;

                                    $(".optionGroup input:checked").each(function ()
                                    {
                                        $(this).removeAttr('checked');
                                    })

                                    $('.cartItems .row').each(function()
                                    {
                                        if ($(this).attr('product_id') == info.product_id && $(this).attr('product_option_id') == info.product_option_id && $(this).attr('product_option_value_id') == info.product_option_value_id)
                                        {
                                            $row = $(this);
                                        }
                                    })

                                    // 动画特效
                                    var $height = 0;
                                    $('.cartItems .row').each(function(i)
                                    {
                                        $height += $(this).innerHeight();
                                    })
                                    _this.cartItemsHeight = $height;

                                    $row.css('background', 'rgba(187, 187, 187, 1)');
                                    setTimeout(function()
                                    {
                                        $row.css('background', 'rgba(187, 187, 187, 0)');
                                    }, 500);
                                })
                            }
                        )
                    })
                })
            }
            else if (type == '?')
            {
                var html = '<div class="popoverTitle">'+ title +'</div><div class="jsContent"><p>'+ info +'</p></div>';
                var style =
                {
                    top: ($dom.offset().top + $dom.height() + 20) + 'px',
                    left: $dom.offset().left - $('.core-popover').width() / 2 + 'px',
                    maxWidth: '300px'
                };
            }

            this.floating_box =
            {
                isShow: true,
                html: html,
                styleObject: style
            }

            function dlHtml(dom)
            {
                var dl ='';
                for (var i in dom)
                {
                    dl += '<dt>'+ i +'</dt>';

                    if (dom[i][0] == '')
                    {
                        dl += '<dd>'+ dom[i][1] +'</dd>';
                    }
                    else if (dom[i][1] == '')
                    {
                        dl += '<dd>'+ dom[i][0] +'</dd>';
                    }
                    else
                    {
                        dl += '<dd>'+ dom[i][0] + '<br />' + dom[i][1] +'</dd>';
                    }
                    dl += '<dd class="contentEnd"></dd>';
                }
                return dl + '</dl></div>';
            }
        },
        Photos: function()  //照片
        {
            var _this = this;
            this.photos.isShow = true;

            setTimeout(function()
            {
                _this.photos.image_show = true;
            }, 500);
        },
        Switch: function(flage)  //照片切换
        {
            this.photos.image_opacity = 0;
            var _this = this;
            setTimeout(function()
            {
                _this.photos.image_opacity = 1;

                if (flage)
                {
                    _this.photos.image_index--;
                    if (_this.photos.image_index < 0) _this.photos.image_index = _this.photos.image_length - 1;
                }
                else
                {
                    _this.photos.image_index++;
                    if (_this.photos.image_index > _this.photos.image_length - 1) _this.photos.image_index = 0;
                }
            }, 300);
        },
        refer: function(ev, product_id, product_option_id, product_option_value_id, quantity, index, ext)  //购物车增删
        {
            var _this = this;

            if (this.delivery.isp == 1 && !this.info.d_open || this.delivery.isp == 2 && !this.info.t_open)
            {
                this.moveIn(ev, 'notOpen', this.info.name,'This restaurant is currently unavailable for ordering.');
                return;
            }
            if (index != null)  //调料可选
            {
                var product_ext_id = _this.cart[index].product_ext_id.replace(/,$/,"");
            }
            if (product_id == 'two')
            {
                this.moveIn(ev, 'plus', 'Please select a variety to add');
                setTimeout(function()
                {
                    _this.floating_box.isShow = _this.exposeMask = false;
                }, 1000)
                return;
            }

            if (!product_option_id) product_option_id = product_option_value_id = 0;

            // if (!(this.delivery.zone_id && this.delivery.shipping_orderDate && this.delivery.shipping_orderTime))  // 1

            // if (!(this.delivery.isp == 2 && this.delivery.shipping_orderDate && this.delivery.shipping_orderTime)) // 2

            if (this.delivery.isp == 1)
            {
                if (!this.delivery.zone_id)
                {
                    showData(this);
                    return;
                }
                if (!this.info.time_open)
                {
                    if (!this.delivery.shipping_orderDate || !this.delivery.shipping_orderTime)
                    {
                        showData(this);
                        return;
                    }
                }
            }
            else if(this.delivery.isp == 2)
            {
                if (!this.info.time_open)
                {
                    if (!this.delivery.shipping_orderDate || !this.delivery.shipping_orderTime)
                    {
                        showData(this);
                        return;
                    }
                }
            }


            if (ext)
            {
                if (ext.length != 0)  //调料
                {
                    this.moveIn(ev, 'seasoning', ext, {product_id: product_id, product_option_id: product_option_id, product_option_value_id: product_option_value_id});
                    return;
                }
            }
            console.log(4);

            if (quantity == -1 && _this.cart[index].quantity == 1)  //去除购物车提示
            {
                var parameter =
                {
                    location_id: _this.info.location_id,
                    product_id: product_id,
                    product_option_id: product_option_id,
                    product_option_value_id: product_option_value_id,
                    quantity: quantity,
                    product_ext_id: product_ext_id,
                    ext: 0
                };
                this.moveIn('', 'less', parameter);
                return;
            }
            if (quantity == 1 && ev.target.click)  //添加购物车提示
            {
                this.moveIn(ev, 'plus', 'Added');
                setTimeout(function()
                {
                    _this.floating_box.isShow = _this.exposeMask = false;
                }, 1000)
            }


            $.post
            (
                '/index.php?route=shop/info/ajaxReturn',
                {
                    location_id: _this.info.location_id,
                    product_id: product_id,
                    product_option_id: product_option_id,
                    product_option_value_id: product_option_value_id,
                    quantity: quantity,
                    product_ext_id:　product_ext_id,
                    ext: 0  //必须存在 ext 否则不增加
                },
                function(data)
                {
                    _this.cart = data.cart; //购物车
                    _this.price = data.price;  //价格
                    _this.couponList = data.couponList;  //与价格相关的优惠
                    _this.bounds = data.bounds;  //优惠券

                    _this.$nextTick(function()
                    {
                        var $row;

                        if (ev.target.tagName == 'SPAN')
                        {
                            $row = $(ev.target).parents('.row');
                        }
                        else
                        {
                            $('.cartItems .row').each(function()
                            {
                                if ($(this).attr('product_id') == product_id && $(this).attr('product_option_id') == product_option_id && $(this).attr('product_option_value_id') == product_option_value_id)
                                {
                                    $row = $(this);
                                }
                            })
                        }

                        // 动画特效
                        var $height = 0;
                        $('.cartItems .row').each(function(i)
                        {
                            $height += $(this).innerHeight();
                        })
                        _this.cartItemsHeight = $height;

                        $row.css('background', 'rgba(187, 187, 187, 1)');
                        setTimeout(function()
                        {
                            $row.css('background', 'rgba(187, 187, 187, 0)');
                        }, 500);
                    })
                }
            )

            function showData(_this)  //运输、时间 选择框
            {
                _this.exposeMask = true;
                _this.floating_box =
                {
                    isShow: false,
                    time: true,
                    styleObject:
                    {
                        position: 'fixed',
                        top: '50%',
                        left: '50%',
                        transform: 'translate(-50%, -50%)',
                        maxWidth: '675px',
                        width: '675px'
                    },
                    parameter:
                    {
                        product_id: product_id,
                        product_option_id: product_option_id,
                        product_option_value_id: product_option_value_id,
                        quantity: quantity,
                        ext: ext
                    }
                };

                _this.$nextTick(function()
                {
                    var date = new Date(),
                        m = date.getMonth() + 1,
                        d = date.getDate();
                    date.setMonth(m);
                    date.setDate(0);
                    var Plusdate = date.getDate() - d,
                        maxDate = '+1M +'+ Plusdate +'';

                    $("#datepicker").datepicker
                    ({
                        minDate: 0,
                        maxDate: maxDate,
                        dateFormat: "D, d M y",
                        beforeShowDay: nonWorkingDates
                    });

                    function nonWorkingDates(date)
                    {
                        var day = date.getDay(),
                            closedDays = _this.info.days,  //禁用星期
                            closeDate = _this.info.unavailable;  //禁用时间
                        for (var i in closeDate)
                        {
                            var start = closeDate[i][0],
                                end = closeDate[i][1];

                            if (date.getDate() >= new Date(start * 1000).getDate() && date.getDate() <= new Date(end * 1000).getDate() && date.getDate())
                            {
                                return [false];
                            }
                            // if (+date/1000 >= start && +date/1000 <= end)
                            // {
                            //     return [false];
                            // }
                        }

                        for (var i in closedDays)
                        {
                            if (closedDays[i] == day) return [true];
                        }

                        return [false];
                    }

                    // 时间延迟
                    var delayedDate = new Date();

                    var day = delayedDate.getDay(),
                        closedDays = _this.info.days,  //禁用星期
                        closeDate = _this.info.unavailable;  //禁用时间

                    // 禁用的周
                    for (var i = 0; i < 7; i++)
                    {
                        if (closedDays.indexOf(i) == -1 && i == day) delayedDate.setTime(Date.now() + 86400000);
                    }

                    // 禁用的时间
                    for (var i in closeDate)
                    {
                        var start = closeDate[i][0],
                            end = closeDate[i][1];

                        if (delayedDate.getDate() >= new Date(start * 1000).getDate() && delayedDate.getDate() <= new Date(end * 1000).getDate() && delayedDate.getDate())
                        {
                            console.log(1)
                            delayedDate.setTime(end * 1000 + 86400000);
                        }
                    }


                    // 如果当天的时间有延迟则不显示
                    if (new Date().getDay() != delayedDate.getDay())
                    {
                        $('#a').text('The next open day is ' + a('l, j M', +delayedDate / 1000));
                        console.log(+delayedDate / 1000);
                        // _this.info_box.time = 'The next open day is ' + a('l, j M', delayedDate);
                        delayedDate = '';
                    }
                    $("#datepicker").datepicker( 'setDate' , delayedDate);

                    $('.sprite').off().click(function()
                    {
                        $("#datepicker").focus();
                    })

                    /**
                     * 和PHP一样的时间戳格式化函数
                     * @param  {string} format    格式
                     * @param  {int}    timestamp 要格式化的时间 默认为当前时间
                     * @return {string}           格式化的时间字符串
                     */
                    function a(format, timestamp){
                        var a, jsdate=((timestamp) ? new Date(timestamp*1000) : new Date());
                        var pad = function(n, c){
                            if((n = n + "").length < c){
                                return new Array(++c - n.length).join("0") + n;
                            } else {
                                return n;
                            }
                        };
                        var txt_weekdays = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
                        var txt_ordin = {1:"st", 2:"nd", 3:"rd", 21:"st", 22:"nd", 23:"rd", 31:"st"};
                        var txt_months = ["", "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
                        var f = {
                            // Day
                            d: function(){return pad(f.j(), 2)},
                            D: function(){return f.l().substr(0,3)},
                            j: function(){return jsdate.getDate()},
                            l: function(){return txt_weekdays[f.w()]},
                            N: function(){return f.w() + 1},
                            S: function(){return txt_ordin[f.j()] ? txt_ordin[f.j()] : 'th'},
                            w: function(){return jsdate.getDay()},
                            z: function(){return (jsdate - new Date(jsdate.getFullYear() + "/1/1")) / 864e5 >> 0},
                            // Week
                            W: function(){
                                var a = f.z(), b = 364 + f.L() - a;
                                var nd2, nd = (new Date(jsdate.getFullYear() + "/1/1").getDay() || 7) - 1;
                                if(b <= 2 && ((jsdate.getDay() || 7) - 1) <= 2 - b){
                                    return 1;
                                } else{
                                    if(a <= 2 && nd >= 4 && a >= (6 - nd)){
                                        nd2 = new Date(jsdate.getFullYear() - 1 + "/12/31");
                                        return date("W", Math.round(nd2.getTime()/1000));
                                    } else{
                                        return (1 + (nd <= 3 ? ((a + nd) / 7) : (a - (7 - nd)) / 7) >> 0);
                                    }
                                }
                            },
                            // Month
                            F: function(){return txt_months[f.n()]},
                            m: function(){return pad(f.n(), 2)},
                            M: function(){return f.F().substr(0,3)},
                            n: function(){return jsdate.getMonth() + 1},
                            t: function(){
                                var n;
                                if( (n = jsdate.getMonth() + 1) == 2 ){
                                    return 28 + f.L();
                                } else{
                                    if( n & 1 && n < 8 || !(n & 1) && n > 7 ){
                                        return 31;
                                    } else{
                                        return 30;
                                    }
                                }
                            },
                            // Year
                            L: function(){var y = f.Y();return (!(y & 3) && (y % 1e2 || !(y % 4e2))) ? 1 : 0},
                            //o not supported yet
                            Y: function(){return jsdate.getFullYear()},
                            y: function(){return (jsdate.getFullYear() + "").slice(2)},
                            // Time
                            a: function(){return jsdate.getHours() > 11 ? "pm" : "am"},
                            A: function(){return f.a().toUpperCase()},
                            B: function(){
                                // peter paul koch:
                                var off = (jsdate.getTimezoneOffset() + 60)*60;
                                var theSeconds = (jsdate.getHours() * 3600) + (jsdate.getMinutes() * 60) + jsdate.getSeconds() + off;
                                var beat = Math.floor(theSeconds/86.4);
                                if (beat > 1000) beat -= 1000;
                                if (beat < 0) beat += 1000;
                                if ((String(beat)).length == 1) beat = "00"+beat;
                                if ((String(beat)).length == 2) beat = "0"+beat;
                                return beat;
                            },
                            g: function(){return jsdate.getHours() % 12 || 12},
                            G: function(){return jsdate.getHours()},
                            h: function(){return pad(f.g(), 2)},
                            H: function(){return pad(jsdate.getHours(), 2)},
                            i: function(){return pad(jsdate.getMinutes(), 2)},
                            s: function(){return pad(jsdate.getSeconds(), 2)},
                            //u not supported yet
                            // Timezone
                            //e not supported yet
                            //I not supported yet
                            O: function(){
                                var t = pad(Math.abs(jsdate.getTimezoneOffset()/60*100), 4);
                                if (jsdate.getTimezoneOffset() > 0) t = "-" + t; else t = "+" + t;
                                return t;
                            },
                            P: function(){var O = f.O();return (O.substr(0, 3) + ":" + O.substr(3, 2))},
                            //T not supported yet
                            //Z not supported yet
                            // Full Date/Time
                            c: function(){return f.Y() + "-" + f.m() + "-" + f.d() + "T" + f.h() + ":" + f.i() + ":" + f.s() + f.P()},
                            //r not supported yet
                            U: function(){return Math.round(jsdate.getTime()/1000)}
                        };
                        return format.replace(/[\\]?([a-zA-Z])/g, function(t, s){
                            if( t!=s ){
                                // escaped
                                ret = s;
                            } else if( f[s] ){
                                // a date function exists
                                ret = f[s]();
                            } else{
                                // nothing special
                                ret = s;
                            }
                            return ret;
                        });
                    }
                })
            }
        },
        Oselect: function(ev, isp)  //运输方式
        {
            var _this = this,
                zone_id;

            ev.target.tagName == 'SELECT' ? zone_id = ev.target.value : zone_id = null;

            $.post
            (
                '/index.php?route=shop/info/ajaxReturn',
                {
                    location_id: this.info.location_id,
                    zone_id: zone_id,
                    isp: isp
                },
                function(data)
                {
                    _this.price = data.price;  //价钱信息
                    _this.delivery.zone_id = data.delivery.zone_id; //默认选择
                    _this.delivery.isp = data.delivery.isp; //默认选择
                    _this.couponList = data.couponList;  //与价格相关的优惠
                    _this.info = data.shopInfo;
                }
            )
        },
        oCoupon: function (id)  //优惠券
        {
            var _this = this;
            $.post
            (
                '/index.php?route=shop/info/ajaxReturn',
                {
                    location_id: _this.info.location_id,
                    coupon_id: id
                },
                function(data)
                {
                    _this.couponList = data.couponList;  //优惠券更新
                    _this.price = data.price; //价格更新
                    _this.info = data.shopInfo;  //信息更新
                }
            )
        },
        pay: function(ev)  //提交
        {
            if (this.cart.length == 0)
            {
                this.moveIn('', 'notCart');
            }
            else if (this.price.remain < this.price.min)
            {
                this.moveIn('', 'notPrice');
            }
            else if (this.delivery.isp == 1 && !this.delivery.zone_id)
            {
                this.moveIn('', 'select');
            }
            else
            {
                ev.target.submit();
            }
        },
        proceed: function(ev)  //验证
        {
            var _this = this;
            var oForm = ev.target;
            var onoff = true;

            if (oForm.isp.value == 1)
            {
                if (oForm.zone_id.value == 0)
                {
                    this.info_box.select = 'Please select a suburb from the list';
                    onoff = false;
                }
            }
            else
            {
                this.info_box.select = '';
            }

            if (!this.info.time_open)
            {
                if ((!oForm.shipping_orderDate.value || oForm.shipping_orderTime.value == '--') && onoff)
                {
                    this.info_box.time = 'Please select a suburb from the time';
                    onoff = false;
                }
                else
                {
                    this.info_box.time = '';
                }
            }
            else
            {
                oForm.shipping_orderDate = oForm.shipping_orderTime = '';
            }


            if (onoff)
            {
                $.post
                (
                    '/index.php?route=shop/info/ajaxReturn',
                    {
                        location_id: _this.info.location_id,
                        isp: oForm.isp.value,
                        zone_id: oForm.zone_id.value,
                        shipping_orderDate: oForm.shipping_orderDate.value,
                        shipping_orderTime: oForm.shipping_orderTime.value,
                        product_id: this.floating_box.parameter.product_id,
                        product_option_id: this.floating_box.parameter.product_option_id,
                        product_option_value_id: this.floating_box.parameter.product_option_value_id,
                        quantity: this.floating_box.parameter.quantity,
                        ext: _this.floating_box.parameter.ext.length
                    },
                    function (data)
                    {
                        _this.delivery = data.delivery;  //运输方式
                        _this.cart = data.cart; //购物车
                        _this.price = data.price;  //价格
                        _this.floating_box.time = _this.exposeMask = false;
                        _this.couponList = data.couponList;  //与价格相关的优惠

                        console.log(_this.floating_box.parameter.ext.length);
                        if (_this.floating_box.parameter.ext.length != 0)
                        {
                            _this.moveIn(window, 'seasoning', _this.floating_box.parameter.ext, {product_id: _this.floating_box.parameter.product_id, product_option_id: _this.floating_box.parameter.product_option_id, product_option_value_id: _this.floating_box.parameter.product_option_value_id});
                            return;
                        }

                        _this.$nextTick(function()
                        {
                            var $row
                            if (ev.target.tagName == 'SPAN')
                            {
                                $row = $(ev.target).parents('.row');
                            }
                            else
                            {
                                $('.cartItems .row').each(function()
                                {
                                    if ($(this).attr('product_id') == _this.floating_box.parameter.product_id && $(this).attr('product_option_id') == _this.floating_box.parameter.product_option_id && $(this).attr('product_option_value_id') == _this.floating_box.parameter.product_option_value_id)
                                    {
                                        $row = $(this);
                                    }
                                })
                            }

                            // 动画特效
                            var $height = 0;
                            $('.cartItems .row').each(function(i)
                            {
                                $height += $(this).innerHeight();
                            })
                            _this.cartItemsHeight = $height;

                            $row.css('background', 'rgba(187, 187, 187, 1)');
                            setTimeout(function()
                            {
                                $row.css('background', 'rgba(187, 187, 187, 0)');
                            }, 500);
                        })
                    }
                )
            }
        },
        scrollable: function(type)
        {
            if (type)
            {
                if($('.items > .special').length >= this.scrollableIndex + 2)
                {
                    this.scrollables -= $('.items > .special').eq(this.scrollableIndex).width() + 22;
                    this.scrollableIndex ++;
                }
            }
            else
            {
                if(this.scrollableIndex > 0)
                {
                    this.scrollableIndex --;
                    this.scrollables += $('.items > .special').eq(this.scrollableIndex).width() + 22;
                }
            }

            this.scrollableIndex == 0 ? $('.scroller .disabled').css('opacity', .35) : $('.scroller .disabled').css('opacity', 1);
            this.scrollableIndex + 1 == $('.items > .special').length ? $('.scroller .rightArrow').css('opacity', .35) : $('.scroller .rightArrow').css('opacity', 1);
        },
        times: function ()
        {
            var _this = this;
            $.post
            (
                '/index.php?route=shop/info/ajaxReturn',
                {
                    location_id: this.info.location_id,
                    day: new Date($("#datepicker").val()).getDay()
                },
                function(data)
                {
                    _this.info = data.shopInfo;
                }
            )
        },
        isp: function (num)
        {
            var _this = this;
            $('#orderTime').val($('#orderTime option:eq(0)').val());
            $.post
            (
                '/index.php?route=shop/info/ajaxReturn',
                {
                    location_id: this.info.location_id,
                    isp: num
                },
                function(data)
                {
                    _this.delivery = data.delivery;
                }
            )
        }
    }
})