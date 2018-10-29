<template>
    <div class="cart-item">
        <span class="decrease-button" @click="decrease()"><i class="material-icons">remove</i></span>
        <span class="shoppingCart-item-name">
            <p class="orderItem-name">
                <span class="orderItem-name-text">{{orderItem.item.name}}</span>
                <span class="orderItem-quantity">X {{orderItem.quantity}}</span>
            </p>
            <ul v-if="app_conf.show_option">
                <li class="orderItem-choice" v-for="(choice,index) in orderItem.item.choices" :key="`choice${index}`">
                    {{choice.type}} : {{choice.pickedChoice}} {{choice.price}}
                </li>
                <li class="orderItem-choice" v-for="(option,index2) in orderItem.item.options" :key="`option${index2}`">
                    <span>{{option.option_name}}</span>
                    <span>{{option.pickedOption}}</span>
                    <span>{{app_conf.currency}} ${{option.price}}</span>
                </li>
            </ul>
        </span>
        <span class="shoppingCart-item-price">
            {{totalPrice}}

        </span>
        <span class="increase-button" @click="increase()"><i class="material-icons">add</i></span>
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
      "table_number",
      "app_conf"
    ])
  },
  mounted() {
    let optionPrice = 0;
    if (this.app_conf.show_option) {
      this.orderItem.item.options.forEach(option => {
        optionPrice = optionPrice + parseFloat(option.price);
      });
    }

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
  overflow: scroll;
  margin: 2px 0px;

  border-radius: 8px;
  box-shadow: 0px 5px 5px #00000045;
}
.decrease-button {
  border-top-left-radius: 8px;
  border-bottom-left-radius: 8px;
  width: 10%;
  height: 100%;
  background-color: #eb4d4b;
  display: flex;
  flex-direction: column;
  justify-content: center;
  text-align: center;
  color: white;
}
.increase-button {
  border-top-right-radius: 8px;
  border-bottom-right-radius: 8px;
  width: 10%;
  height: 100%;
  background-color: #eb4d4b;
  display: flex;
  flex-direction: column;
  justify-content: center;
  text-align: center;
  color: white;
}

ul {
  list-style-type: none;
  padding: 0;
  overflow: scroll;
  li {
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    margin-bottom: 5px;
    overflow: scroll;
    .shoppingCart-item-name {
      flex: 4;
      overflow: scroll;
      padding-left: 2px;
      .orderItem-name {
        margin: 0;
        font-size: 14px;
        font-weight: bold;
        display: flex;
        justify-content: space-between;
        overflow: scroll;
        .orderItem-quantity {
          flex: 1;
        }
        .orderItem-name-text {
          flex: 4;
        }
      }
      .orderItem-choice {
        margin: 0;
        font-size: 10px;
        color: #9d9a9a;
        overflow: scroll;
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
