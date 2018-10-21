<template>
    <!-- check orderlist is empty or not, to decide show or hide the shopping cart -->
    <div v-if="orderList.length>0" class="shoppingCart" :class="{expand:!isExpand}">
        <!-- header will always show when shopping cart is not empty -->
        <div class="shoppingCart-header" @click="toggle">
            <div class="shoppingIcon">
                <i class="material-icons">shopping_cart</i>
                <span class="badge">{{totalQuantityOfOrder}}</span>
            </div>
            <div class="shoppingCart-header-text">Total: {{totalPriceOfOrder}}</div>
        </div>
        <!-- toggle the list of order on clicking the header -->
        <ul>
            <!-- just a list of order item :smile -->
            <li v-for="(orderItem,index) in orderList" :key="index">
                <span class="shoppingCart-item-name">
                    <p class="orderItem-name">{{orderItem.item.name}}</p>
                    <ul>
                        <li class="orderItem-choice" v-for="(choice,index) in orderItem.item.choices" :key="index">
                            {{choice.type}} : {{choice.pickedChoice}}
                        </li>
                    </ul>
                </span>
                <div class="shoppingCart-button-group">
                    <div class="button-group-container">
                            <span @click="decrease(orderItem,index)">-</span>
                            <span>{{orderItem.quantity}}</span>
                            <span @click="increase(orderItem)">+</span>
                    </div>
                </div>
                <span class="shoppingCart-item-price">
                    {{(orderItem.quantity * parseFloat(orderItem.item.price)).toFixed(2)}}
                </span>
            </li>
        </ul>
        <!-- confirm order -->
        <button class="shoppingCart-confirm-button" @click="confirmOrder">Confirm Order</button>
    </div>
</template>

<script>
import { mapState, mapMutations, mapGetters, mapActions } from "vuex";
export default {
  name: "app-shopping-cart",
  data() {
    return {
      isExpand: false
    };
  },
  computed: {
    ...mapGetters([
      "orderList",
      "totalPriceOfOrder",
      "totalQuantityOfOrder",
      "orderId",
      "table_number"
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
        }/payment`
      );
    }
  }
};
</script>

<style lang="scss" scoped>
.shoppingCart {
  position: fixed;
  background-color: white;
  bottom: 0;
  width: 100%;
  z-index: 200;
  box-shadow: 0px -5px 5px #00000038;
  .shoppingCart-header {
    display: flex;
    position: relative;
    justify-content: center;
    height: 40px;
    background-color: #eb4d4b;
    .shoppingIcon {
      color: #eb4d4b;
      display: inline-block;
      background: white;
      transform: scale(1.6);
      width: 30px;
      height: 30px;
      border-radius: 50%;
      box-shadow: 0px 2px 2px #00000078;
      z-index: 250;
      position: absolute;
      top: 0;
      left: 20px;
      align-items: center;
      padding-left: 3px;
      top: -10px;
      padding-top: 3px;
    }
    .badge {
      display: inline-block;
      padding: 0.25em 0.4em;
      font-size: 75%;
      font-weight: 700;
      background-color: #7ed6df;
      line-height: 1;
      text-align: center;
      white-space: nowrap;
      vertical-align: baseline;
      border-radius: 50%;
      color: #535c68;
      position: absolute;
      top: -4px;
      right: -2px;
    }
    .shoppingCart-header-text {
      display: flex;
      align-items: center;
      font-size: 16px;
      color: white;
    }
  }
  ul {
    list-style-type: none;
    padding: 0;
    padding-left: 10px;
    max-height: 300px;
    overflow: scroll;
    li {
      display: flex;
      flex-direction: row;
      justify-content: space-between;
      margin-bottom: 5px;
      .shoppingCart-item-name {
        flex: 4;
        .orderItem-name {
          margin: 0;
          font-size: 16px;
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
    width: 100%;
    border: none;
    background-color: #f6e58d;
    color: #f0932b;
    font-weight: bold;
    box-shadow: 0px -1px 3px #00000045;
  }
}
.expand {
  max-height: 40px;
}
</style>
