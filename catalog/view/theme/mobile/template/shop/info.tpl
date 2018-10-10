<?php echo $header; ?>
<script src="/catalog/view/theme/mobile/script/info.js" defer="defer"></script>
<script defer="defer">
$(function() {
    $('#accountLoginButton').click(function() {
        event.preventDefault();
        if ($('#emailAddress').val() != '' && $('#password') != '') {
            $.post(
                '/index.php?route=checkout/login/save', {
                    email: $('#emailAddress').val(),
                    password: $('#password').val()
                },
                function(data) {
                    if (data.error) {
                        $('#message_login').show();
                    }
                    if (data.length == '') {
                        $('#loading').show();
                        location.reload();
                    }
                }
            )
        }
    })
    //忘记密码
    $('#resetPasswordButton').click(function() {
        console.log(1)
        $.post(
            '/index.php?route=account/forgotten/save', {
                email: $('#emailAddress_F').val()
            },
            function(data) {
                if (data.error) {
                    $('#message_forgotten').show();
                }
                if (data.length == '') {
                    $('#passwordEmailSent').show();
                    $('#message_forgotten').hide();
                }
            }
        )
        event.preventDefault();
    })
})
</script>
<style>
    ._msg_popup {
        display: table;
        width: 100%;
        color: rgb(0, 0, 0);
        opacity: 1;
        background-color: rgb(253, 219, 11);
        font-size: 14px;
        padding: 10px 15px;
        box-sizing: border-box;
        transition: opacity 1s;
    }

    ._msg_popup .icon-clock {
        width: 10%;
        padding-right: 10px;
        font-size: 40px;
    }

    ._msg_popup span {
        display: table-cell;
        vertical-align: middle;
    }

    ._close {
        width: 10%;
        font-weight: bold;
        font-size: 30px;
        font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
    }
    .isqrcodes{
        padding-top: 47px !important;
    }
    .isshows{
        padding-top: 0px!important;
    }
</style>
<div class="topBodyWrapWidth m-container venuePage" id="info" :class="{ isshows : isshow, isqrcodes: isqrcode }">
    <!--顶部-->
    <div id="mlTopToolbar" class="topBodyWrapWidth topToolbar clearfix" v-if="!isshow">

        <div class="websiteTopToolbar clearfix" v-if="!isqrcode">

            <div class="toolbarLeft toolbarLeftButtons">
                <a href="javascript:history.go(-1);" id="toolbarBackButtonLink">
                    <div class="button-back icon-back"></div>
                </a>
            </div>

            <div class="toolbarRight">
                <div class="dropdown burgerMenuButton">
                    <a @click="nav = true" class="dropdown-toggle" id="m-top-dropdownmenu" role="button"
                       href="javascript:void(0);" data-toggle="dropdown"
                       data-target="#">
                        <div class="burgerMenu icon-hamburgerMenu"></div>
                    </a>
                    <div v-show="nav" @click="nav = false" class="dropdown-backdrop"></div>
                    <ul v-show="nav" class="dropdown-menu nav pull-right semiBoldFont" style="display: block">
                        <li><a href="/" style="border-top:0;">Home</a></li>
                        <?php if($logged){ ?>
                        <li><a href="<?php echo $order;?>">Re-order</a></li>
                        <li><a href="<?php echo $detail;?>">My Details</a></li>
                        <li><a href="<?php echo $logout;?>" >Log out</a></li>
                        <?php } else { ?>
                        <li><a class="accountLink" @click="login = backdrop = true">Log in</a></li>
                        <?php }?>
                    </ul>
                </div>
            </div>


            <div class="toolbarMiddle">
                <a href="/" class="toolbarHomebutton "><span class="icon-logoWide"></span></a>
            </div>

        </div>

        <div class="pageHeader headerWithRhsText  info-bar clearfix venuePage">
            <div id="orderStatusBar" class="pageHeader showOrderStatus clearfix">
                <div class="left">
                    <p id="venuePageMinOrderAmt" class="semiBoldFont"></p>
                </div>
                <div class="right button" @click="cartShow = backdrop = true">
                    <div class="cartIcon icon-cart"></div>
                    <div class="orderAmtText regularFont"><span id="venuePageCurrentOrderAmt">{{price.productPrice}}</span></div>
                    <span id="countTotalOrderItems" class="orderItemTotal semiBoldFont">{{cartl}}</span>
                </div>
            </div>
        </div>
    </div>
    <!--店铺信息-->
    <div class="pageInfoBar">
        <div class="restaurantLogo">
        <a href="/">
            <img class="logoImg"
                 :src="info.logo"
                 alt="logo"></a>
        </div>
        <div @click="moreInfo = backdrop = true" class="restaurantInfoArea">
            <span class="restaurantName">{{info.name}}</span>

            <div class="venueSchedule">
                <span class="icon-clock"></span>
                <span class="openTime lightFont">Open {{info.open}}</span>
            </div>

            <div class="viewTermsConditions">
                <span id="takeawayTermsLink" class="regularFont">More Info</span>
                <span class="arrow-down"></span>
            </div>
        </div>
    </div>
    <!--促销信息-->
    <div class="_msg_popup" v-show="item.show" v-for="item in info.shopInfo" v-if="!isqrcode">
        <span class="icon-clock"></span>
        <span class="_urgencymsg">{{item.info}}</span>
        <span class="_close" @click="item.show = false">×</span></div>
    <!--菜单选项-->
    <div @click="reviewsShow = backdrop = true" id="ratingSection" class="jsReviewsLink" v-if="!isqrcode">
        <div class="ratingStarTotalReviews">
            <div class="venuePageratingStars">
                <div v-for="n in star.neatly" class="ratingStarImg full icon-star"></div>
                <div v-if="info.star != star.neatly" class="ratingStarImg half icon-star" style="width: 20px; height: 18px"></div>
                <div v-for="n in star.remaining" class="ratingStarImg empty icon-star"></div>
            </div>
            <div class="totalReviews lightFont">(<span itemprop="count">{{info.totalReview}}</span>)</div>
            <meta itemprop="rating" content="8.0">
            <meta itemprop="average" content="8.0">
            <meta itemprop="best" content="10">
            <div class="icon-forward"></div>
        </div>
    </div>
    
    <!--菜单-->
    <div id="allMenusSection" v-if="!isshow">
        <ul id="menuSections">
            <li v-if="couponList" v-if="!isqrcode">
                <a @click="specials.taggle = !specials.taggle" href="javascript:void(0);" class="toggleMenuSection"
                   id="link_course_promotions" v-if="!isqrcode">
                    <div class="toggleImg" :class="{selected: specials.taggle}"></div>
                    <div class="menuSectionName specialMenuSection semiBoldFont">Specials</div>
                </a>
                <div id="specialsSection" v-show="specials.taggle" style="display: block">
                    <div class="specialsContainer" v-for="item in couponList">
                        <div class="specialUnit clearfix">
                            <!--<div class="discountHighlight right regularFont"></div>-->
                            <div class="discountDescription left">
                                <span class="specialTitle semiBoldFont">{{item.name}}</span>
                                <div class="discountDescriptionText regularFont"><p>{{item.description}}</p></div>
                            </div>
                        </div>
                    </div>
                </div>
            </li>
            <li v-for="(item, idx) in menu">
                <a @click="item.show = !item.show" href="javascript:void(0);" class="toggleMenuSection"
                   id="link_course_popular_dishes">
                    <div class="toggleImg" :class="{selected: item.show}"></div>
                    <div class="menuSectionName semiBoldFont"><span class="popular icon-star" v-if="idx == 0"></span>{{item.name}}
                    </div>
                </a>
                <ul class="courseMenuList" v-show="item.show">
                    <li v-for="val in item.foodItems" v-if="!isqrcode" @click="Oselected(val.id, val.price[0].ext)">
                        <div class="foodItemLHS clearfix">
                            <div class="price right" v-for="price in val.price">
                                <div class="addToCart"><span class="icon-plus" ></span></div>
                                <div class="singlePrice">{{price.price}}</div>
                            </div>
                            <div class="boldFont foodItemName"> {{val.subtitle}}
                                <span class="foodAttribute vegetarian" :class="{'icon-star': val.special.popular}"></span>
                                <span class="foodAttribute chilli" :class="{'icon-spicy1': val.special.hot}"></span>
                                <span class="foodAttribute vegetarian" :class="{'icon-vegetarian': val.special.veg}"></span>
                                <span class="foodAttribute vegetarian" :class="{'icon-health': val.special.heath}"></span>
                            </div>
                            <div class="clearfix"></div>
                            <div class="foodItemBottom clearfix">
                                <div class="foodItemDescription lightFont">
                                    <p>{{val.description}}</p>
                                </div>

                                <!--<div class="actionButton button semiBoldFont">-->
                                    <!--Customise-->
                                <!--</div>-->
                            </div>
                        </div>

                    </li>
                    <li v-for="val in item.foodItems" v-if="isqrcode" @click="refer($event, 1, val.id)">
                        <div class="foodItemLHS clearfix">
                            <div class="price right" v-for="price in val.price">
                                <div class="addToCart"><span class="icon-plus" ></span></div>
                                <div class="singlePrice">{{price.price}}</div>
                            </div>
                            <div class="boldFont foodItemName"> {{val.subtitle}}
                                <span class="foodAttribute vegetarian" :class="{'icon-star': val.special.popular}"></span>
                                <span class="foodAttribute chilli" :class="{'icon-spicy1': val.special.hot}"></span>
                                <span class="foodAttribute vegetarian" :class="{'icon-vegetarian': val.special.veg}"></span>
                                <span class="foodAttribute vegetarian" :class="{'icon-health': val.special.heath}"></span>
                            </div>
                            <div class="clearfix"></div>
                            <div class="foodItemBottom clearfix">
                                <div class="foodItemDescription lightFont">
                                    <p>{{val.description}}</p>
                                </div>

                                <!--<div class="actionButton button semiBoldFont">-->
                                    <!--Customise-->
                                <!--</div>-->
                            </div>
                        </div>

                    </li>
                </ul>
            </li>
        </ul>
    </div>
    <!--购物车-->
    <div id="wholeShoppingCart" class="modal in" v-show="cartShow" aria-hidden="false">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button @click="cartShow = backdrop = false" type="button" class="close" data-dismiss="modal"
                            aria-hidden="true"></button>
                    <div class="mm-header-title boldFont">Your order</div>
                    <div class="changePreOrderDetailsSection semiBoldFont"  v-if="!isqrcode">FOR <span id="currentCartType">{{delivery.isp == 1 ? 'Pick up' : 'Delivery'}}</span>
                        <a id="changePreOrderDetails" @click="Oselect('change')">Change {{delivery.isp == 1 ? 'Delivery' : 'Pick up'}}</a>
                        <div class="openInfoArrow"></div>
                    </div>
                </div>
                <div class="modal-body mm-body">

                    <div id="cartSummarySection">
                        <div class="mm-section cartSummary editable">
                            <div v-for="item in cart" class="notBundleChildFoodItem mm-section-item clearfix">
                                <a href="javascript: void(0);" class="jsDecQty" @click="refer($event, -1, item.product_id, item.product_ext_id)">
                                    <div class="decreaseQty">]</div>
                                </a>
                                <span style="float: left; padding-left: 10px; margin-top: -2px;">{{item.quantity}}</span>
                                <a href="javascript: void(0);" class="jsIncQty" @click="refer($event, 1, item.product_id, item.product_ext_id)">
                                    <div class="increaseQty">c</div>
                                </a>
                                <div class="cartItemDesc">
                                    <div class="regularFont cartItemLabel">{{item.name}}</div>
                                    <span class="optionPrice">{{item.price}}</span>
                                    <span class="optionName">chocie(s): <span v-for="(item, key) in item.exts"><span v-for="val in item.exts">{{val.name}} </span></span></span>
                                    <div class="contentEnd"></div>
                                </div>
                            </div>
                        </div>
                        <div class="mm-section gray cartTotalsBlock clearfix">
                            <div class="subTotalOnly">
                                <span class="subTotalText semiBoldFont">SUBTOTAL</span>
                                <span class="subTotalValue semiBoldFont priceText">{{price.productPrice}}</span>
                            </div>
                        </div>
                        <div class="mm-section gray cartTotalsBlock orderSummary">
                            <template v-if="!isqrcode">
                            <div class="contentEnd"></div>
                            <div class="orderCost deliveryFee semiBoldFont contentBox">
                                 <div style="float:right;"><span class="deliveryFeeText">delivery fee</span><span
                                        class="priceText">{{price.deliveryPrice}}</span></div>
                            </div>
                            <div class="contentEnd"></div>
                            <div class="orderCost deliveryFee semiBoldFont contentBox">
                                <div style="float:right;">
                                    <span class="deliveryFeeText" style="padding-right: 5px">Choose a bonus</span>
                                    <span class="priceText">
                                        <select @change="bonus" v-model="coupon">
                                            <option v-for="el in couponList" v-if="el.isShow" :value="el.id">{{el.name}}</option>
                                        </select>
                                    </span>
                                </div>
                            </div>
                            </template>
                            <div class="contentEnd"></div>
                            <div class="orderCost subTotalOnly semiBoldFont contentBox"><span
                                    class="subTotalText">TOTAL</span><span class="subTotalValue priceText">{{price.total}}</span>
                            </div>
                            <div class="contentEnd"></div>
                        </div>
                    </div>
                </div>
                <div id="shoppingCartModalFooter" class="modal-footer">
                    <div class="modal-footer-button-box">
                        <a @click="cartShow = backdrop = false" onclick="return false;" class="modal-footer-button modal-footer-cancel regularFont" href=""
                           data-dismiss="modal">Cancel</a>
                        <a id="totalsCheckout" @click="checkout()"
                           class="modal-footer-button modal-footer-continue semiBoldFont">Confirm</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--选择提单方式-->
    <div v-show="orderSelect" id="preOrderDetailsSection" class="modal in" aria-hidden="false" v-if="!isqrcode">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button @click="orderSelect = backdrop = false" type="button" class="close" data-dismiss="modal"
                            aria-hidden="true"></button>
                    <div class="mm-header-title boldFont">Start your order</div>
                </div>
                <div class="modal-body mm-body">
                    <form id="form_confirmPreOrderDetails" class="preOrderDetailsForm">
                        <div class="mm-title firstSection semiBoldFont">ORDER TYPE</div>
                        <div class="selectCartType mm-section">
                            <div class="selectCartType mm-section-item no-self-padding">
                                <input type="radio" name="cartType" id="cartType_delivery" class="radioButton"
                                       :value="1" v-model="delivery.isp" @change="Oselect">
                                <label for="cartType_delivery" class="confirmPreOrderLabel radioLabel">
                                    <span>Delivery</span>
                                </label>
                            </div>

                            <div class="selectCartType mm-section-item no-self-padding">
                                <input type="radio" name="cartType" id="cartType_pickUp" class="radioButton"
                                       :value="2" v-model="delivery.isp" @change="Oselect">
                                <label for="cartType_pickUp" class="confirmPreOrderLabel radioLabel">
                                    <span>Pick up</span>
                                </label>
                            </div>

                        </div>
                        <div class="contentEnd"></div>

                        <template v-if="delivery.isp == 1">
                            <div class="mm-title" id="venueClosedWarning0">Please choose your delivery suburb</div>
                            <div class="mm-section">
                                <div @click="areaFlag(true)" class="mm-section-item">
                                    <span v-for="item in delivery.areaList" v-if="item.id == delivery.zone_id">{{item.name}}</span>
                                    <span v-if="delivery.zone_id == 0" class="remindStrengthen">Select address...</span>
                                    <div class="openInfoArrow"></div>
                                </div>
                            </div>
                            <div class="contentEnd"></div>
                        </template>
                        <template>
                            <div class="mm-title" id="venueClosedWarning">Restaurant closed. Choose pick up time</div>
                            <div class="mm-section">
                                <div @click="dateFlag(true)" class="mm-section-item" id="selectDaySection">
                                    <span id="selectedDayName">{{dateed.when}}</span>
                                    <div class="openInfoArrow"></div>
                                </div>
                                <div @click="timeFlag(true)" class="mm-section-item" id="selectTimeSection">
                                    <div id="selectedTimeName" class="inlineBlock" :class="{remindStrengthen: timeed == 'Select time...'}">{{timeed}}</div>
                                    <div class="openInfoArrow"></div>
                                </div>
                            </div>
                        </template>
                        <div class="contentEnd"></div>
                        <div class="mm-title beforeFooter"></div>
                    </form>

                </div>
                <div class="modal-footer">
                    <div class="modal-footer-button-box">
                        <a @click="orderSelect = backdrop = false" onclick="return false;" class="modal-footer-button modal-footer-cancel regularFont" href=""
                           data-dismiss="modal">Cancel</a>
                        <a @click="refer($event, 1, selected_id)" href="" onclick="return    false;"
                           class="modal-footer-button modal-footer-continue semiBoldFont"
                           id="link_submitPreOrderDetails">Start your order</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--选择地区-->
    <div v-show="areaShow" class="modal in" aria-hidden="false" v-if="!isqrcode">
        <div class="modal-dialog">
            <div class="modal-content no-footer">
                <div class="modal-header">
                    <button @click="areaFlag(false)" type="button" class="close" data-dismiss="modal"
                            aria-hidden="true"></button>
                    <div class="mm-header-title boldFont">Update Address</div>
                </div>
                <div class="modal-body mm-body">
                    <div class="mm-section">
                        <div class="mm-section-item no-self-padding" v-for="(item, idx) in delivery.areaList">
                            <input type="radio" :id="item.id" :value="Number(item.id)" class="radioButton" v-model="delivery.zone_id">
                            <label class="radioLabel" :for="item.id"><span>{{item.name}}</span></label>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--选择日期-->
    <div v-show="dateShow" id="modalContainer" class="modal in" aria-hidden="false" v-if="!isqrcode">
        <div class="modal-dialog">
            <div class="modal-content no-footer">
                <div class="modal-header">
                    <button @click="dateFlag(false)" type="button" class="close" data-dismiss="modal"
                            aria-hidden="true"></button>
                    <div class="mm-header-title boldFont">Update Date</div>
                </div>
                <div class="modal-body mm-body">
                    <div class="mm-section">
                        <div v-for="(item, idx) in dates" class="mm-section-item no-self-padding">
                            <input type="radio" :value="item" class="radioButton" :id="'radio' + idx" v-model="dateed">
                            <label class="radioLabel" :for="'radio' + idx"><span>{{item.when}}</span></label>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--选择时间-->
    <div v-show="timeShow" class="modal in" aria-hidden="false" v-if="!isqrcode">
        <div class="modal-dialog">
            <div class="modal-content no-footer">
                <div class="modal-header">
                    <button @click="timeFlag(false)" type="button" class="close" data-dismiss="modal"
                            aria-hidden="true"></button>
                    <div class="mm-header-title boldFont">Update Time</div>
                </div>
                <div class="modal-body mm-body">
                    <div class="mm-section">
                        <div class="mm-section-item no-self-padding" v-for="(item, idx) in info.times">
                            <input type="radio" :value="item" class="radioButton" :id="'orderTimeId_' + idx" v-model="timeed">
                            <label class="radioLabel" :for="'orderTimeId_' + idx"><span>{{item}}</span></label>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--选择附加-->
    <div v-show="asidShow" class="modal in" aria-hidden="false">
        <div class="modal-dialog">
            <div class="modal-content no-footer">
                <div class="modal-header">
                    <button @click="asidFlag(false)" type="button" class="close" data-dismiss="modal"
                            aria-hidden="true"></button>
                    <div class="mm-header-title boldFont">Make your choice</div>
                </div>
                <div class="modal-body mm-body">
                    <template v-for="(item, key, index) in ext">
                        <p style="text-align: center; margin-top: 20px">{{key}}</p>
                        <div class="mm-section check">
                            <div class="mm-section-item no-self-padding" v-for="el in item.exts">
                                <input :name="key" type="radio" :value="el.product_ext_id" class="radioButton" :id="'orderTimeId_1' + el.product_ext_id" @change="Ochange(key, el.product_ext_id)">
                                <label class="radioLabel" :for="'orderTimeId_1' + el.product_ext_id"><span>{{el.name + '&nbsp;&nbsp;' + el.price}}</span></label>
                            </div>
                        </div>
                    </template>
                </div>
            </div>
        </div>
    </div>
    <!--最新评论-->
    <div v-show="reviewsShow" id="venueReviewsSection" class="modal in" aria-hidden="false" v-if="!isqrcode">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button @click="reviewsShow = backdrop = false" type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                    <div class="mm-header-title boldFont">Recent reviews</div>
                </div>
                <div class="modal-body mm-body">
                    <ul>
                        <li v-for="item in reviews" class="reviewBox"><p class="reviewRating"><span class="overallRating">Overall {{item.total_rating}}</span> -
                            Food {{item.rating}} | Value {{item.rating1}} | Speed {{item.rating2}}</p>
                            <p class="reviewComment"></p>
                            <p class="reviewFooter"><span class="reviewAuthor">{{item.name}} </span> <span class="reviewDate">- {{item.date_add}}</span>
                            </p></li>
                    </ul>
                </div>
                <div class="modal-footer">
                    <div class="modal-footer-button-box">
                        <a @click="reviewsShow = backdrop = false" href="javascript:void(0);" class="modal-footer-button modal-footer-cancel regularFont"
                           >Cancel</a>

                        <a @click="reviewsShow = backdrop = false" href="javascript:void(0);" class="modal-footer-button modal-footer-continue semiBoldFont"
                           >Continue</a>
                    </div>
                </div>

            </div>
        </div>
    </div>
    <!--开店时间-->
    <div v-show="moreInfo" class="modal" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content no-footer">
                <div class="modal-header">
                    <button @click="moreInfo = backdrop = false" type="button" class="close" data-dismiss="modal"
                            aria-hidden="true"></button>
                    <div class="mm-header-title boldFont">Indian Mumtaj Restaurant</div>
                </div>
                <div class="modal-body mm-body venue-info" style="">
                    <div class="mm-section gray">
                        <div class="mm-section-item no-self-padding venue-info-cuisine no-border">Indian</div>
                    </div>
                    <div class="mm-title semiBoldFont">ADDRESS</div>
                    <div class="mm-section gray">
                        <div class="mm-section-item no-self-padding no-border condition">{{info.address}}</div>
                    </div>
                    <div class="mm-title semiBoldFont schedule">DELIVERY HOURS</div>
                    <div class="mm-section">
                        <div class="mm-section-item clearfix" v-for="(value, key) in schedule.delivery"><span class="scheduleDay">{{key}}</span>
                            <div class="scheduleTimes clearfix"><span class="scheduleTime">{{value[0]}}</span></div>
                        </div>
                    </div>
                    <div class="mm-title semiBoldFont schedule">TAKEAWAY HOURS</div>
                    <div class="mm-section">
                        <div class="mm-section-item clearfix" v-for="(value, key) in schedule.takeaway"><span class="scheduleDay">{{key}}</span>
                            <div class="scheduleTimes clearfix"><span class="scheduleTime">{{value[0]}}</span></div>
                        </div>
                    </div>
                    <div class="mm-title beforeFooter"></div>
                </div>
                <div class="modal-footer">
                    <div class="modal-footer-button-box"><a onclick="return false;" @click="moreInfo = backdrop = false"
                                                            class="modal-footer-button modal-footer-cancel regularFont"
                                                            href="" data-dismiss="modal">Cancel</a> <a
                            onclick="return false;" @click="moreInfo = backdrop = false" class="modal-footer-button modal-footer-continue semiBoldFont"
                            href="" data-dismiss="modal">Continue</a></div>
                </div>
            </div>
        </div>
    </div>
    <!--登陆-->
    <div v-show="login" class="modal in" aria-hidden="false" v-if="!isqrcode">
        <div class="modal-dialog">
            <div v-show="!reg" class="modal-content">
                <div class="modal-header">
                    <button @click="login = backdrop = false" type="button" class="close" data-dismiss="modal"
                            aria-hidden="true"></button>
                    <div class="mm-header-title boldFont">Log in</div>
                </div>
                <div id="accountContentWrap" class="modal-body mm-body">
                    <div class="accountLogin">
                        <form id="loginForm" name="login" method="POST" class="accountForm">
                            <div class="mm-title semiBoldFont">
                                <span>YOUR DETAILS</span>
                                <div id="loginErrorMsg" style="display:none;" class="normError messageSpacing">Incorrect
                                    email or password.
                                </div>
                            </div>

                            <div class="mm-section" id="accountLoginDetails">
                                <div class="mm-section-item">
                                    <label for="emailAddress" class="inputFieldLabel regularFont">Email</label>
                                    <span class="inputFieldSpan">
                                        <input id="emailAddress" type="email" name="emailAddress" value="" autocomplete="off">
                                    </span>
                                </div>
                                <div class="mm-section-item">
                                    <label for="password" class="inputFieldLabel regularFont">Password</label>
                                    <span class="inputFieldSpan">
                                        <input id="password" type="password" name="password" value="" autocomplete="off">
                                    </span>
                                </div>
                            </div>
                            <div class="mm-section gray" style="padding:10px;">
                                <div class="forgottenPassword"><a class="forgotPassword" id="message_login" style="display:none;">Your login details were incorrect.  Please try again</a></div>
                                <div class="footTextContentWrapper">
                                    <div class="GreyText">Don't have an account? Your account will be created the first
                                        time you complete an order.
                                    </div>
                                </div>
                                <div class="forgottenPassword">
                                    <a href="javascript:void(0);" class="forgotPassword" @click="reg = true">Forgot your
                                        password?</a>
                                </div>
                            </div>
                            <input class="hiddenSubmitButton" type="submit" value="login" name="submit">
                        </form>
                    </div>
                </div>
                <div class="modal-footer">
                    <div class="modal-footer-button-box">
                        <a @click="login = backdrop = false" data-dismiss="modal" href="" class="modal-footer-button modal-footer-cancel regularFont"
                           onclick="return false;">Cancel</a>
                        <a id="accountLoginButton" class="modal-footer-button modal-footer-continue semiBoldFont" onclick="return false;">Log In</a>
                    </div>
                </div>
            </div>
            <div v-show="reg" class="modal-content">
                <div class="modal-header">
                    <button @click="reg = false" type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                    <div class="mm-header-title boldFont">Reset password</div>
                </div>
                <div id="accountContentWrap" class="modal-body mm-body">
                    <div id="resendPasswordEmail">
                        <div class="mm-title semiBoldFont">
                            <span style="line-height:18px;">Submit your e-mail address below to receive a password reset link.</span>
                            <div id="message_forgotten" style="display:none;" class="normError messageSpacing">Please enter your current email.
                            </div>
                        </div>

                        <form id="resetPasswordForm" method="POST" class="accountForm">
                            <div class="mm-section" id="accountLoginDetails">
                                <div class="mm-section-item">
                                    <div id="resetPasswordError" style="display:none"
                                         class="normError messageSpacing"></div>
                                    <label for="emailAddress_F" class="inputFieldLabel regularFont"
                                           style="width:auto; padding-right:10px;">Email</label>
                                    <span class="inputFieldSpan">
                                        <input id="emailAddress_F" type="email" name="emailAddress_F" value=""
                                        autocomplete="off">
                                    </span>
                                </div>
                            </div>

                            <input class="hiddenSubmitButton" type="submit" value="login" name="submit">
                        </form>
                    </div>

                    <div id="passwordEmailSent" style="display:none; padding:10px;" class="hideInResendPasswordPage">
                        <h1>We have e-mailed you a password reset link. Please check your spam folder if you can't find
                            it in the inbox.</h1>
                    </div>

                </div>
                <div class="modal-footer">
                    <div class="modal-footer-button-box">
                        <a @click="reg = false" data-dismiss="modal" href="" class="modal-footer-button modal-footer-cancel regularFont"
                           onclick="return false;">Cancel</a>
                        <a id="resetPasswordButton" class="modal-footer-button modal-footer-continue semiBoldFont">Continue</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--遮罩层-->
    <div class="modal-backdrop in" v-show="backdrop"></div>
    
    <div style="text-align: center;" v-if="isshow && isqrcode">
        <div>
            <img :src="qrcode_url" style="width:50%" />
        </div>
        <div style="padding:10px;">
            <span @click="isshow=false" style="color: #ff5832;text-decoration: underline;">Edit</span>
        </div>
        <div>
            <ul>
                <li v-for="(v,i) in cart_info">
                    <span>{{ v.name }}</span>
                    <span>x{{ v.quantity }}</span>
                </li>
            </ul>
        </div>
    </div>
</div>
<?php echo $footer; ?>