<template>
<transition>
        <!-- check orderlist is empty or not, to decide show or hide the shopping cart -->
        <div v-if="orderList.length>0" class="shoppingCart" :class="{expand:isExpand}">
            <div class="cover" v-if="isExpand"></div>
            <!-- header will always show when shopping cart is not empty -->
            <div class="shoppingCart-header" :class="{expandHeader:isExpand}" @click="toggle">
                <div class="shoppingIcon">
                    <i class="material-icons">shopping_cart</i>
                    <span class="badge">{{totalQuantityOfOrder}}</span>
                </div>
                <div class="shoppingCart-header-text">{{app_conf.total}} {{app_conf.currency}} ${{totalPriceOfOrder}}</div>
                <div v-if="isExpand" @click="toggle" class="close-btn-wrap"><i @click="toggle" class="material-icons">close</i></div>
            </div>
            <!-- toggle the list of order on clicking the header -->
            <ul v-if="isExpand">
                <!-- just a list of order item :smile -->
                <li v-for="(orderItem,index) in orderList" :key="index">
                    <CartItem :orderItem="orderItem"></CartItem>
                </li>
            </ul>
            <!-- confirm order -->
            <button v-if="isExpand" class="shoppingCart-confirm-button" @click="confirmOrder">{{app_conf.confirm_order}}</button>
        </div>
</transition>
</template>

<script>
import { mapState, mapMutations, mapGetters, mapActions } from "vuex";
import CartItem from "./CartItem.vue";
export default {
  name: "app-shopping-cart",
  data() {
    return {
      isExpand: false
    };
  },
  components: {
    CartItem
  },
  computed: {
    ...mapGetters([
      "orderList",
      "totalPriceOfOrder",
      "totalQuantityOfOrder",
      "orderId",
      "table_number",
      "isEN",
      "cdt",
      "v",
      "app_conf"
    ])
  },
  mounted() {},
  methods: {
    ...mapActions([
      "increaseItemQuantityInOrderList",
      "decreaseItemQuantityInOrderList",
      "removeItemQuantityFromOrderList"
    ]),
    /**methods to control only this component */
    toggle() {
      this.isExpand = !this.isExpand;
    },
    increase(orderItem) {
      this.increaseItemQuantityInOrderList(orderItem);
    },
    decrease(orderItem) {
      this.decreaseItemQuantityInOrderList(orderItem);
    },
    //ToDo:: save data in database.
    confirmOrder() {
      console.log(this.orderList);
      this.$router.push(
        `/table/public/table/${this.table_number}/orderid/${
          this.orderId
        }/payment?cdt=${this.cdt}&v=${this.v}`
      );
    }
  }
};
</script>

<style lang="scss" scoped>
.cover {
  position: fixed;
  top: 0;
  left: 0;
  height: 100vh;
  width: 100vw;
  background-color: #0000009c;
  z-index: -1;
}
.close-btn-wrap {
  position: absolute;
  right: 10px;
  top: 10px;
}
.shoppingCart {
  position: fixed;
  bottom: 10px;
  width: 70%;
  left: 15%;
  z-index: 200;
  box-shadow: 0px 5px 5px #00000038;

  .shoppingCart-header {
    display: flex;
    position: relative;
    justify-content: center;
    height: 40px;
    // background-image: url("http://www.aupos.com.au/wp-content/uploads/2017/03/logo.png");
    // background-repeat: no-repeat;
    // background-size: contain;
    background-color: rgba(235, 77, 75, 0.8);
    transition: all 0.3s;
    &.expandHeader {
      border-top-left-radius: 8px;
      border-top-right-radius: 8px;
      background-color: rgb(235, 77, 75);
      transition: all 0.3s;
    }
    .shoppingIcon {
      display: inline-block;
      transform: scale(1.6);
      width: 26px;
      height: 20px;
      z-index: 250;
      position: absolute;
      top: 10px;
      left: 14px;
    }
    .badge {
      display: inline-block;
      border-radius: 50%;
      color: #f8fafc;
      text-shadow: 1px 1px 2px black;
      position: absolute;
      top: -4px;
      left: 3px;
    }
    .shoppingCart-header-text {
      display: flex;
      align-items: center;
      font-weight: 600;
      font-size: 18px;
      color: white;
      text-shadow: 1px 1px 2px black;
      letter-spacing: 1.2px;
    }
    img {
      max-width: 60px;
    }
  }
  ul {
    list-style-type: none;
    padding: 0;
    padding-left: 10px;
    max-height: 300px;
    overflow: scroll;
    background-color: white;
    margin: 0;
    padding-bottom: 50px;
    border-bottom-left-radius: 8px;
    border-bottom-right-radius: 8px;
    li {
      display: flex;
      flex-direction: row;
      justify-content: space-between;
      margin-bottom: 5px;
      .shoppingCart-item-name {
        flex: 4;
        .orderItem-name {
          margin: 0;
        }
        .orderItem-choice {
          margin: 0;
          font-size: 10px;
          color: #9d9a9a;
        }
      }
      .shoppingCart-button-group {
        flex: 2;
        text-align: center;
        .button-group-container {
          border: 1px solid #dff9fb;
          display: flex;
          align-items: flex-start;
          justify-content: space-around;
          justify-items: center;
          span {
            font-size: 16px;
            font-weight: bold;
            display: inline-block;
            text-align: center;
          }
        }
      }
      .shoppingCart-item-price {
        flex: 1;
        text-align: right;
        padding-right: 10px;
      }
    }
  }

  .shoppingCart-confirm-button {
    width: 190px;
    position: fixed;
    height: 30px;
    bottom: 3%;
    left: calc(50% - 95px);
    border: none;
    background-color: #ffc24a;
    color: #fff;
    font-size: 16px;
    letter-spacing: 0.6px;
    font-weight: 900;
    text-shadow: 1px 1px 2px black;
    box-shadow: 0px 5px 5px #00000038;
    border-radius: 8px;
  }
}
.expand {
  width: 90%;
  left: 5%;
  bottom: 5%;
  transition: all 0.3s;
}
i.material-icons {
  color: white;
  text-shadow: 0px 0px 1px black;
  font-size: 20px;
}
</style>
