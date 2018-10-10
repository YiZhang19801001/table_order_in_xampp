<?php echo $header; ?>
<script type="text/javascript" src="/catalog/view/theme/menulog/script/info.js" defer></script>
<style>
    .greenStarHalf:before, .course-nav li.highlight a, .core-popover .core-closeX::after, .core-closeX
    {
        color: <?php echo $_SESSION['color'];?> !important;
    }
    .radioTab [type=radio]:checked ~ label, .minimumOrderAmountMessagePopover .minimumOrderMessagePrompt .minimumOrderMessageOrLine, .minimumOrderAmountMessagePopover .minimumOrderMessagePrompt .minimumOrderMessageOr, .clickable input[type="radio"]:checked+label:after, input[type="radio"]:not(.regularRadio):checked+label:after
    {
        background-color: <?php echo $_SESSION['color'];?> !important;
    }
    .border, .specialsScroller .special, .minimumOrderAmountMessagePopover .minimumOrderMessagePrompt
    {
        border-color: <?php echo $_SESSION['color'];?> !important;
    }

    .color1
    {
        color: <?php echo $_SESSION['color1'];?> !important;
    }
    .background1
    {
        background-color: <?php echo $_SESSION['color1'];?> !important;
    }
    .specialsScroller .special
    {
        border-color: <?php echo $_SESSION['color1'];?> !important;
    }
    .select .arr:before
    {
        border-top-color: <?php echo $_SESSION['color'];?> !important;
    }
    progress::-moz-progress-bar { background: <?php echo $_SESSION['color'];?>; }
    progress::-webkit-progress-bar { background: <?php echo $_SESSION['color'];?>; }
    progress::-webkit-progress-value  { background: <?php echo $_SESSION['color'];?>; }

    @media not all, not all, only screen and (-webkit-min-device-pixel-ratio: 2), not all
    {
        .shoppingCart div.cartItems div.itemQty
        {
            width: 40px;
        }
        .shoppingCart div.cartItems div.itemQty .incDec
        {
            display: inline-block;
            float: none;
        }
        .shoppingCart div.cartItems .foodItem .value
        {
            width: 40px;
        }
    }
</style>
<div id="app" v-cloak>
    <div id="exposeMask" style="position: fixed; top: 0px; left: 0px; right: 0; bottom: 0;z-index: 999; opacity: .4"
         v-if="exposeMask"></div>
    <div class="core-popover core-popoverBox core-popoverNoTitle core-popoverHelper core-popoverFocused venuePagePopup"
         :style="floating_box.styleObject"
         :class="{ in: floating_box.isShow , minimumOrderAmountMessagePopover: mini}"
         style="z-index: 10000; max-width: 450px; position: absolute; overflow: auto; max-height: 700px;">
        <a class="core-closeX" @click="floating_box.isShow = exposeMask = false"></a>
        <div class="core-contentBox core-contentBoxNoTitle" v-html="floating_box.html">
        </div>
    </div>

    <!--时间范围-->
    <div class="core-popover core-popoverBox core-popoverNoTitle core-popoverGeneral chooseSuburbDateTime popoverWithOverlay core-popoverFocused ui-draggable"
         :style="floating_box.styleObject"
         :class="{in: floating_box.time}"
         style="z-index: 10000; max-width: 450px; position: absolute;">
        <a class="core-closeX" @click="exposeMask = floating_box.time = false"></a>
        <div class="core-contentBox core-contentBoxNoTitle">
            <div class="core_ifhBlock">
                <form action="/index.php?route=shop/info/ajaxReturn" method="post"
                      class="takeawayShoppingCartSuburbDateTime core-ajaxForm" @submit.prevent="proceed($event)">
                    <fieldset>
                        <div class="contentEnd"></div>
                        <input type="radio" id="cartType_delivery29760849" name="isp" value="1"
                               class="cartTypeSuburbDateTime" :checked="delivery.isp == 1" @click="isp(1)">
                        <label for="cartType_delivery29760849"><strong>Delivery</strong>&nbsp;&nbsp;</label>
                        <input type="radio" id="cartType_pickUp29760849" name="isp" value="2"
                               class="cartTypeSuburbDateTime" :checked="delivery.isp == 2" @click="isp(2)">
                        <label for="cartType_pickUp29760849"><strong>Pickup</strong></label>
                        <div class="chooseSuburb">
                            <div class="popoverTitle ui-draggable-handle core-popoverDraggable">Please choose your
                                delivery suburb
                            </div>
                            <div class="core-message message"><span class="error">{{info_box.select}}</span></div>
                            <div class="core-left">
                                <div class="suburbWrapper">
                                    <select name="zone_id" class="suburbId" v-model="delivery.zone_id">
                                        <option value="0">-- Select</option>
                                        <option :value="item.id" v-for="item in delivery.areaList"
                                                :selected="item.id == delivery.zone_id">{{item.name}}
                                        </option>
                                    </select>
                                </div>
                            </div>
                            <div class="contentEnd"></div>
                        </div>
                        <template v-if="!info.time_open">
                            <div class="orderOutOfTime popoverTitle spaceAbove">You are ordering out of the restaurant's
                                operating hours
                            </div>
                            <p class="popoverDeliveryPickupMsg">Please select your required <span>delivery      </span>
                                date/time:</p>
                            <div class="orderDateTimeBlock">
                                <div class="core-message message">
                                    <span class="error">{{info_box.time}}</span>
                                    <div id="a" class="orderOutOfTime popoverTitle spaceAbove" style="font-size: 15px;font-weight: normal;"></div>
                                </div>
                                <div class="orderDate">
                                    <ul>
                                        <li>
                                            <input id="datepicker" name="shipping_orderDate" class="orderDateText"
                                                   type="text">
                                            <img class="ui-datepicker-trigger sprite calendar_icon2x">
                                        </li>
                                    </ul>
                                </div>
                                <div class="orderTime">
                                    <ul>
                                        <li>
                                            <div class="orderTimeDiv">
                                                <select id="orderTime" name="shipping_orderTime" class="orderTime"
                                                        @focus="times">
                                                    <option selected="selected">--</option>
                                                    <option v-for="item in info.times">{{item}}</option>
                                                </select>
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </template>
                        <div class="core-dialogueButtons">
                            <button type="submit" class="background1">Continue</button>
                        </div>
                    </fieldset>
                </form>
            </div>
        </div>
    </div>

    <transition name="slide-fade">
        <div class="pp_pic_holder light_rounded" v-if="photos.isShow">
            <div class="ppt" style="opacity: 1; display: block; width: 600px;">&nbsp;</div>
            <div class="pp_top">
                <div class="pp_left"></div>
                <div class="pp_middle"></div>
                <div class="pp_right"></div>
            </div>
            <div class="pp_content_container">
                <div class="pp_left">
                    <div class="pp_right">
                        <div class="pp_content">
                            <div class="pp_loaderIcon" v-if="!photos.image_show"></div>
                            <div class="pp_fade" v-if="photos.image_show" :style="{opacity : photos.image_opacity}">
                                <a href="#" class="pp_expand" title="Expand the image"
                                   style="display: none;">Expand</a>
                                <div class="pp_hoverContainer" style="height: 400px; width: 600px;">
                                    <a class="pp_next" @click="Switch(false)" href="javascript:;">next</a> <a
                                        class="pp_previous" href="javascript:;" @click="Switch(true)">previous</a>
                                </div>
                                <div id="pp_full_res">
                                    <img id="fullResImage" :src="info.photos[photos.image_index]"
                                         style="height: 400px; width: 600px;">
                                </div>
                                <div class="pp_gallery">
                                    <a href="javascript:;" class="pp_arrow_previous" style="display: none;">Previous</a>
                                    <div style="transform: translateX(-50%)"
                                         :style="{width: photos.image_length * (50+7) + 'px'}">
                                        <ul :style="{width: photos.image_length * (50+7) + 'px'}">
                                            <li v-for="(image, index) in info.shop_images"
                                                :class="{selected : photos.image_index == index}">
                                                <a href="#">
                                                    <img :src="image.thumb" width="50">
                                                </a>
                                            </li>
                                        </ul>
                                    </div>
                                    <a href="javascript:;" class="pp_arrow_next" style="display: none;">Next</a></div>
                                <div class="pp_details" style="width: 600px;">
                                    <div class="pp_nav" style="display: none;"><a href="#" class="pp_play">Play</a>
                                        <a href="#" class="pp_arrow_previous">Previous</a>
                                        <p class="currentTextHolder">1/1</p> <a href="#" class="pp_arrow_next">Next</a>
                                    </div>
                                    <p class="pp_description" style="display: none;"></p>
                                    <div class="pp_social"></div>
                                    <a class="pp_close" href="javascript:;"
                                       @click="photos.isShow = false;  photos.image_show = false">Close</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="pp_bottom">
                <div class="pp_left"></div>
                <div class="pp_middle"></div>
                <div class="pp_right"></div>
            </div>
        </div>
    </transition>
    <div class="pp_overlay" v-if="photos.isShow" @click="photos.isShow = photos.image_show = false"></div>
    <div class="content">
        <div class="contentBody">
            <div class="venueTakeawayPage">
                <div class="fullWidthWrapper1 venueInfoWrapper1" style="margin-top: 0px;">
                    <div class="fullWidthWrapper2 venueInfoWrapper2" :style='bg'>
                        <div class="fullWidthWrapper3 venueInfoWrapper3">
                            <div class="venueTakeawayInfo">
                                <a href="/">
                                    <img :src="info.logo" class="venueImage"/>
                                </a>
                                <h1 id="restaurantTitleTakeaway">{{info.name}}</h1>
                                <p>
                                    <span class="icon-location"></span>&nbsp;
                                    {{info.address}}
                                </p>
                                <div class="info1" style="height: 62px; width: 230px;">
                                    <p id="venueInfoCuisines">
                                        <span class="icon-food"></span>&nbsp;
                                        <span>{{info.tag}}</span>
                                    </p>
                                    <dl>
                                        <dt><span class="icon-clock"></span>&nbsp;{{'Open '+ info.opendata + ' between'
                                            }}:
                                        </dt>
                                        <dd>
                                        <span id="link_takeawaySchedule" @mouseover="moveIn($event, 'open')"
                                              @mouseout="floating_box.isShow = false">{{info.is_open ? info.opentime : "Close"}}</span>
                                        </dd>
                                    </dl>
                                </div>
                                <div class="info2" style="height: 62px; width: 95px;">
                                    <p class="noSpaceBelow">
                                        <span id="link_takeawayAbout" href="#" @mouseover="moveIn($event, 'about')"
                                              @mouseout="floating_box.isShow = false">About us</span>
                                    </p>
                                    <p class="noSpaceBelow">
                                        <span id="link_viewTakeawayGallery" class="clickable" @click="Photos">Photos ({{photos.image_length}})</span>
                                    </p>
                                </div>
                                <div class="info3" style="width: 180px;">
                                    <div>
                                        <a :href="info.reviews + '&location_id='+ info.location_id "
                                           class="ratingStars">
                                            <span v-for="n in star.neatly" class="star greenStarFull theme-font-color"
                                                  style="font-size: 20px;">b</span>
                                            <span v-if="info.star != star.neatly" class="star greenStarHalf"
                                                  style="font-size: 20px;">b</span>
                                            <span v-for="n in star.remaining" class="star whiteStarEmpty"
                                                  style="font-size: 20px;">b</span>
                                        </a>
                                        <a :href="info.reviews + '&location_id='+ info.location_id " class="ratingTotal"
                                           style="display: block; padding-top: 5px; text-decoration: underline;">{{info.totalReview}}
                                            customer reviews &gt;</a>
                                    </div>
                                </div>
                                <div class="info4" style="height: 62px;">
                                    <div class="contentEnd"></div>
                                    <p class="smallSpaceAbove smallSpaceBelow theme-color1">Minimum order:&nbsp;&nbsp;<span>{{price.consume}}</span>
                                    </p>
                                    <div class="contentEnd"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="specialsScroller" class="specialsScroller scroller">
                    <div class="srollableWrapper" style="float:left; max-width:1000px;">
                        <a @click="scrollable(false)" class="prev leftArrow disabled"></a>
                        <div class="scrollable" style="max-width: inherit; width: 964px;">
                            <div class="items" style="transition: 1s" :style="{left : scrollables + 'px'}">
                                <div id="link_discountloyalty" class="special specialLoyalty" name="discountloyalty"
                                     v-for="coupon in couponList">
                                    <div class="couponBox">
                                        <h3 @mouseover="moveIn($event, 'coupon', coupon.name, coupon.description)"
                                            @mouseout="floating_box.isShow = false" class="theme-font-color1">{{coupon.name}}</h3>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <a @click="scrollable(true)" class="next rightArrow"></a>
                    </div>
                    <div class="contentEnd"></div>
                </div>
                <div id="conditionsScheduleInfo">
                    <ul>
                        <li class="remindVenueClosed" v-for="item in info.shopInfo"><span>{{item.info}}</span></li>
                    </ul>
                    <div class="contentEnd"></div>
                </div>
                <div id="blockTakeawayMenu" class="blockTakeawayMenu">
                    <div class="course-nav" data-course-nav="">
                        <div class="gradient-wrapper" data-gradient-wrapper="" style="width: 130px;"
                             :class="{fixed : isFixed}">
                            <a href="javascript:;" data-scroll-top="" class="scroll-top theme-font-color" @click="iscrollTop(0, 'top')">
                                <img :src="info.color == 'orange' ? '/catalog/view/theme/menulog/image/arrow-up-orange.svg' : '/catalog/view/theme/menulog/image/arrow-up.svg'" role="presentation"
                                     aria-hidden="true"> Go to First
                            </a>
                            <div class="course-nav-wrapper" style="height: 100%; overflow: hidden;">
                                <ul style="position: absolute;">
                                    <li :id=" 'link_course' + index" :class="{'highlight' : index == isIndex}"
                                        v-for="(name, index) in menu">
                                        <a href="javascript:;" class="jsCourseNavLink" @click="iscrollTop(index)">
                                            <img :src="info.color == 'orange' ? '/catalog/view/theme/menulog/image/arrow-right-orange.svg' : '/catalog/view/theme/menulog/image/arrow-right.svg'">
                                            {{name.name}}
                                        </a>
                                    </li>
                                </ul>
                            </div>
                            <a href="javascript:;" class="scroll-bottom theme-font-color" @click="iscrollTop(menu.length - 1, 'bottom')">
                                <img :src="info.color == 'orange' ? '/catalog/view/theme/menulog/image/arrow-down-orange.svg' : '/catalog/view/theme/menulog/image/arrow-down.svg'"> Go to last
                            </a>
                        </div>
                    </div>
                    <div class="takeawayMenu" style="padding-bottom:252px">
                        <ul id="courseList" class="menu">
                            <li :id=" 'course' + index" class="course" v-for="(item, index) in menu">
                                <h3><span v-if="item.name == 'Popular Dishes'" class="icon-star"></span>&nbsp;{{item.name}}
                                </h3>
                                <div class="sectionDescription" v-html="item.description">
                                </div>
                                <ul class="foodItems">
                                    <li class="foodItem jsFoodItem61418767"
                                        v-for="(list, index) in item.foodItems"
                                        :class="{ foodItemOdd: index % 2 == 1, foodItemEven: index % 2 == 0}">
                                        <div click class="foodItemInfoWrapper foodItemWithExtraInfo"
                                             id="foodItemInfoWrapper1642112514">
                                            <div class="menuItemImageLightbox itemPhotoWrapper" v-if="list.img">
                                                <a class="link_foodPhoto camera"
                                                   @click="moveIn($event, 'img', list.img)">
                                                    <img :src="list.img">
                                                </a>
                                                <div class="hidden">
                                                    <a rel="prettyPhoto[menuItemImageLightbox]"
                                                       href="//www.menulog.com.au/generated_content/crm_photos/view/7433483_e5b4c39216333331952379fe4c761cde/Butter%20Chicken%20%28Mild%29%20%28GF%29.jpeg"></a>
                                                </div>
                                            </div>
                                            <div class="foodItemInfo">
                                                <h4 click @click="list.price.length == 1 ? refer($event, list.id, list.price.option_id, list.price.option_value_id, 1, null, list.price[0].ext) : refer($event, 'two')">
                                                    <span class="extraInfoPointToThis"></span>{{list.subtitle}}
                                                    <span v-if="list.special.popular" class="icon-star"></span>
                                                    <span v-if="list.special.hot" class="icon-spicy1"></span>
                                                    <span v-if="list.special.veg" class="icon-vegetarian"></span>&nbsp;
                                                    <img v-if="list.special.health"
                                                         src="/catalog/view/theme/menulog/image/healthy-choice.png"
                                                         alt="H+" title="Healthy+">
                                                </h4>
                                                <p class="noSpaceBelow"
                                                   @click="list.price.length == 1 ? refer($event, list.id, list.price.option_id, list.price.option_value_id, 1, null, list.price[0].ext) : refer($event, 'two')" v-html="list.description">
                                                    </p>
                                            </div>
                                        </div>
                                        <form action="#">
                                            <div class="varieties jsBrowserVer">
                                                <p class="addItem" v-for="price in list.price">
                                                    <span>{{price.name+ ' ' + price.price}}</span>
                                                    <input click class="sprite add2x itemVarietiesAdd addButton"
                                                           type="button"
                                                           @click="refer($event, list.id, price.option_id, price.option_value_id, 1, null, price.ext)">
                                                </p>
                                            </div>
                                        </form>
                                        <div class="contentEnd"></div>
                                    </li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                    <div style="float: left;">
                        <div class="takeawayMenuRHS" style="position: static;" :class="{fixed : isFixed}">
                            <div class="takeawayMenuShoppingCartWrapper">
                                <div class="cartTitle">Your Order</div>
                                <div class="cartTypeOptions finalistWinner">
                                    <form id="cartTypeOptions" action="/takeaway/ajax_update_cart.php"
                                          class="cartTypeRadios core-ajaxForm">
                                        <input type="hidden" name="action" value="updateCartType">
                                        <div class="radioTabs">
                                            <div class="radioTab cartTypeRadios">
                                                <input id="delivery" class="regularRadio" type="radio" name="cartType"
                                                       @click="Oselect($event, 1)"
                                                       :checked="delivery.isp == 1">
                                                <label for="delivery" class="radio">
                                                    <span class="icon-delivery"></span>&nbsp;Delivery
                                                </label>
                                                <div class="content">
                                                    <div class="select">
                                                        <span class="arr"></span>
                                                        <select @change="Oselect($event, 1)">
                                                            <option value="0">-- Select</option>
                                                            <option :value="item.id" v-for="item in delivery.areaList"
                                                                    :selected="item.id == delivery.zone_id">
                                                                {{item.name}}
                                                            </option>
                                                        </select>
                                                    </div>
                                                    <!-- .select -->
                                                </div>
                                                <!-- .content -->
                                            </div>
                                            <div class="radioTab">
                                                <input id="pickUp" type="radio" class="regularRadio" name="cartType"
                                                       value="pickUp" @click="Oselect($event, 2)"
                                                       :checked="delivery.isp == 2">
                                                <label for="pickUp" class="radio"><span class="icon-pickup"></span>&nbsp;Pick-up</label>
                                                <div class="content"></div>
                                            </div>
                                        </div>
                                        <!-- .radioTabs -->
                                    </form>
                                    <div class="contentEnd"></div>
                                </div>
                                <div class="contentEnd"></div>
                                <div id="menuRHSBottomWrapperdelivery">
                                    <div id="cartSummary"
                                         class="shoppingCart shoppingCartEditable shoppingCartMenuPage">
                                        <div id="cartSummaryBox" class="box1">
                                            <div class="contentEnd"></div>
                                            <div class="cartContent" style="overflow-y: auto; max-height: 200px;">
                                                <div></div>
                                                <div class="cartEmpty" v-if="cart.length == 0">There are no items in
                                                    your cart.
                                                </div>
                                                <div class="cartItems" :style="{height: cartItemsHeight + 'px'}">
                                                    <div class="row" v-for="(item, index) in cart"
                                                         :product_id="item.product_id"
                                                         :product_option_id="item.option.product_option_id ? item.option.product_option_id : 0"
                                                         :product_option_value_id="item.option.product_option_value_id ? item.option.product_option_value_id : 0">
                                                        <div class="details">
                                                            <div class="namePrice foodItem">
                                                                <div class="name">{{item.name}}</div>
                                                                <div class="itemQty">
                                                                    <a href="javascript:;" class="incDec">
                                                                        <span class="icon-minus"
                                                                              @click="refer($event, item.product_id, 0, 0, -1, index, 0)"
                                                                              v-if="item.option.length"></span>
                                                                        <span class="icon-minus"
                                                                              @click="refer($event, item.product_id, item.option.product_option_id, item.option.product_option_value_id, -1, index, 0)"
                                                                              v-else></span>
                                                                    </a>{{item.quantity}}<a href="javascript:;"
                                                                                            class="incDec">
                                                                    <span class="icon-plus"
                                                                          @click="refer($event, item.product_id, 0, 0, 1, index, 0)"
                                                                          v-if="item.option.length"></span>
                                                                    <span class="icon-plus"
                                                                          @click="refer($event, item.product_id, item.option.product_option_id, item.option.product_option_value_id, 1, index, 0)"
                                                                          v-else></span>

                                                                </a>
                                                                </div>
                                                                <div class="value">{{item.price}}</div>
                                                                <div class="contentEnd"></div>
                                                            </div>
                                                            <div class="namePrice" v-if="item.option">
                                                                <div class="name">{{item.option.value}}</div>
                                                            </div>
                                                            <div v-for="(exts, key) in item.exts">
                                                                <div class="namePrice choice"
                                                                     v-for="seasoning in exts.exts">
                                                                    <div class="name">{{key}}: {{seasoning.name}}</div>
                                                                    <div class="itemQty"></div>
                                                                    <div class="value" v-if="key != 'Remove'">
                                                                        {{seasoning.price}}
                                                                    </div>
                                                                    <div class="contentEnd"></div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="contentEnd"></div>
                                                    </div>
                                                </div>
                                                <div class="subTotalSection">
                                                    <div class="row">
                                                        <div class="name subTotal">Subtotal</div>
                                                        <div class="value" id="subTotalValue">{{price.productPrice}}
                                                        </div>
                                                        <div class="contentEnd"></div>
                                                    </div>
                                                </div>
                                                <div class="discountSection">
                                                    <div class="discountSectionTitle">Choose a bonus</div>
                                                    <div class="discounts">
                                                        <div class="row nameNoPrice clickable" v-if="coupon.isShow"
                                                             v-for="(coupon, index) in couponList"
                                                             @click="oCoupon(coupon.id)">
                                                            <input :checked="coupon.is_click" :id="'radio' + index"
                                                                   type="radio" name="discountId" class="smallRadio"
                                                                   value="discountLoyalty">
                                                            <label v-if="coupon.type != 3">{{coupon.name}}
                                                                <br><span class="loyaltyProgressMsg"
                                                                          v-if="coupon.is_click && !info.bounds && coupon.type != 2">{{'-' + price.couponPrice}}</span>
                                                            </label>

                                                            <label v-if="coupon.type == 3">
                                                                {{coupon.name_text}}
                                                            </label>
                                                            <div class="commentLayout"
                                                                 v-if="coupon.type == 2 && coupon.bounds">
                                                                <div class="core-inFieldLabel">
                                                                    <input id="discountTA29316_comment"
                                                                                         type="text" class="comment"
                                                                                         v-model="message" placeholder="Enter your choice"></div>
                                                                <a href="#" class="map1_question jsHelper" @mouseover="moveIn($event, '?', coupon.name, coupon.description)" @mouseout="floating_box.isShow = false">?</a></div>
                                                            <div class="contentEnd"></div>
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                            <div class="cartTotals">
                                                <div class="row" id="deliveryFeeRow">
                                                    <div class="name">Delivery</div>
                                                    <div class="value">{{price.deliveryPrice}}</div>
                                                    <div class="freeDeliveryForOrderOver text"
                                                         style="display: none;"></div>
                                                </div>
                                                <div id="amountLeftForMinimumCost" v-if="price.remain < price.min">
                                                    <div class="row">
                                                        <div class="name">{{price.consume}} min</div>
                                                        <div class="value">{{price.remainPrice}} remaining</div>
                                                        <progress :max="price.min" :value="price.remain"></progress>
                                                    </div>
                                                </div>
                                                <div class="row freeDelivery" style="display: none;">
                                                    <div id="freeDeliveryText">Free Delivery
                                                        <div class="contentEnd"></div>
                                                    </div>
                                                </div>
                                                <div class="row total">
                                                    <div class="name">Total</div>
                                                    <div class="value">{{price.total}}</div>
                                                    <div class="includingGST">Including GST</div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="contentEnd"></div>
                                    <div id="cartSummaryBottom" class="shoppingCart">
                                        <form action="/index.php?route=pay/checkout" method="post"
                                              @submit.prevent="pay($event)">
                                            <input type="hidden" name="discount_comment" :value="message">
                                            <input type="hidden" name="location_id" :value="info.location_id">
                                            <button class="orderNow" type="submit">Place my order</button>
                                        </form>
                                        <span class="discount_more_link" id="link_cartAcceptVoucher"
                                              @mouseover="moveIn($event, 'text')"
                                              @mouseout="floating_box.isShow = false">Voucher</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="contentEnd"></div>
                </div>
            </div>
        </div>
    </div>
</div>
<?php echo $footer; ?>