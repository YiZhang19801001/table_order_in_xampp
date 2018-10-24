<template>
    <div class="cart-item">
        <span class="shoppingCart-item-name">
            <p class="orderItem-name">{{orderItem.item.name}}</p>
            <ul>
                <li class="orderItem-choice" v-for="(choice,index) in orderItem.item.choices" :key="index">
                    {{choice.type}} : {{choice.pickedChoice}}
                </li>
                <li class="orderItem-choice" v-for="(option,index2) in orderItem.item.options" :key="index2">
                    <span>{{option.option_name}}</span>
                    <span>{{option.pickedOption}}</span>
                    <span>AUD ${{option.price}}</span>
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
            {{totalPrice}}

        </span>
    </div>
</template>
<script>
import { mapState, mapMutations, mapGetters, mapActions } from "vuex";

export default {
  name: "app-cart-item",
  props: {
    orderItem: {}
  },
  data() {
    return {
      totalPrice: 0
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
  mounted() {
    let optionPrice = 0;
    this.orderItem.item.options.forEach(option => {
      optionPrice = optionPrice + parseFloat(option.price);
    });

    this.totalPrice = (
      this.orderItem.quantity *
      (parseFloat(this.orderItem.item.price) + optionPrice)
    ).toFixed(2);
  },
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
    increase() {
      this.increaseItemQuantityInOrderList(this.orderItem);
    },
    decrease() {
      this.decreaseItemQuantityInOrderList(this.orderItem);
    }
  }
};
</script>

<style lang="scss" scoped>
.cart-item {
  width: 100%;
  display: flex;
  justify-content: space-between;
}

ul {
  list-style-type: none;
  padding: 0;
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
        font-size: 15px;
        font-weight: bold;
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

.expand {
  max-height: 40px;
}
</style>
