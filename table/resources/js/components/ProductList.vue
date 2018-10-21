<template>
    <div class="productList"  v-scroll-spy ref="listView">

      <!-- List:: show groups for products -->
        <div v-for="(product,index) in productList" :key="index" ref="cates">
            <!-- category title for separating different group of products -->
            <h4 :id="product.categorys.category_id">{{product.categorys.name}}</h4>
            <!-- List:: show products in certain group -->
            <div v-for="item in product.products" :key="item.product_id" class="product"
            v-bind:class="{activeProduct:item.product_id===selectProduct_id}">

            <!-- static info show for each product -->
<transition
            name="productBackgroud"
            enter-active-class="animated fadeIn"
>
                <div v-if="item.product_id===selectProduct_id" class="product-background"></div>
</transition>
<transition>
                    <img
                    src="https://images.pexels.com/photos/461198/pexels-photo-461198.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"
                    alt=""
                    v-bind:class="{activeimg:item.product_id===selectProduct_id}">

</transition>
                <div class="text-container">
                    <h5 v-bind:class="{activeH5:item.product_id===selectProduct_id}">{{item.name}}</h5>
                    <p v-if="item.product_id===selectProduct_id" class="product-description">{{item.description}}</p>
                    <p class="price">${{item.price}}</p>
                </div>
                <!-- button to control folder or expand each product -->
                <transition>
                <button class="button"
                v-bind:class="{active:item.product_id===selectProduct_id,unactive:item.product_id!==selectProduct_id}"
                @click="selectItem(item.product_id)">
                    <i class="material-icons">
                        {{item.product_id===selectProduct_id?"keyboard_arrow_up":"keyboard_arrow_down"}}
                    </i>
                </button></transition>
                <!-- button to add new product to cart -->

                <button class="button active add-button"
                @click="wandOrder(item.product_id)"
                v-if="item.product_id===selectProduct_id"
                >
                    <i class="material-icons">
                        add
                    </i>
                </button>

                <!-- popup pannel for taste choices -->

                <div v-if="wantOrder==true && item.product_id===selectProduct_id" class="cover"></div>

                <transition
                    name="choiceForm"
                    enter-active-class="animated rotateIn"
                    leave-active-class="animated zoomOutDown"
                >
                    <template v-if="wantOrder==true && item.product_id===selectProduct_id">

                        <ChoiceForm key="mykey" v-bind:item="item" @addToOrder="addToOrder" @closeChoiceForm="closeChoiceForm" ></ChoiceForm>
                    </template>
            </transition>
            </div>
        </div>
    </div>

</template>

<script>
import ChoiceForm from "./ChoiceForm.vue";
import { mapGetters, mapActions, mapState, mapMutations } from "vuex";

export default {
  name: "app-product-list",

  data() {
    return {
      //ToDo : is 'section' nessary for scroll-spy
      section: 0,
      //flag for expand or not
      selectProduct_id: 0,
      //flag for popup choices pannel
      wantOrder: false,
      arr: null
    };
  },
  computed: {
    ...mapGetters(["productList", "orderList", "scrollPositionId"])
  },
  watch: {
    section: function() {
      console.log("worked");
      let sum = 0;
      for (let index = 0; index < scrollPositionId; index++) {
        const element = this.$refs.cates[index];
        sum = sum + element.scrollHeight;
      }
      window.scrollY = sum + 50;
    }
  },
  mounted() {
    this.getProductList();
    window.addEventListener("scroll", this.handleScroll);
  },
  destroyed() {
    window.removeEventListener("scroll", this.handleScroll);
  },
  watch: {},
  methods: {
    ...mapMutations(["updateProductList", "updateOrderList"]),
    ...mapActions([
      "getProductList",
      "addNewItemToOrderList",
      "setScrollPositionId"
    ]),

    selectItem(id) {
      /**
       * In Order To toggle the product detail in one button
       * check the id if same with selectProduct_id => dismiss, else set selectProdcut_id = id
       **/
      this.wantOrder = false;
      if (this.selectProduct_id === id) {
        this.selectProduct_id = 0;
      } else {
        this.selectProduct_id = id;
      }
    },

    /** use for choice pannel open or close*/
    wandOrder(item) {
      this.wantOrder = true;
    },
    closeChoiceForm() {
      this.wantOrder = false;
    },
    /**choice pannel end */

    addToOrder(newItem) {
      /**
       * add a new item into order
       * 1. should check is there any duplicate item
       * 2. if have, increate the quantity only
       * 3. if not, this item is new to the order so create new obj and insert to the array
       * 4. final result the array will be like this
       * [{item:{},quantity:number}]*/

      this.wantOrder = false;
      this.addNewItemToOrderList(newItem);
    },
    handleScroll() {
      let sum = 0;
      /** loop the elements check the height to find out which category section now is showing */
      for (let index = 0; index < this.$refs.cates.length; index++) {
        const element = this.$refs.cates[index];
        sum = sum + element.scrollHeight;
        //**ToDo: why here is - 50 I thoungh should be + 50 */
        if (sum - 50 > window.scrollY) {
          this.setScrollPositionId(index);
          /**new step let category list change base on this scrollPostionId */
          break;
        }
      }
    }
  },
  components: { ChoiceForm }
};
</script>

<style lang="scss" scoped>
.cover {
  position: fixed;
  height: 100vh;
  background: #0000009c;
  width: 100vw;
  z-index: 600;
  top: 0;
  left: 0;
}
.productList {
  margin-top: 50px;
  margin-bottom: 50px;
  width: 70%;
  box-shadow: 0px 2px 3px #00000038;
  padding: 0px 5px 10px 5px;

  //position: relative;

  .product {
    color: #797876;
    padding: 13px;
    min-height: 80px;
    margin: auto;
    margin-bottom: 5px;
    width: 80%;
    position: relative;
    display: flex;
    box-shadow: 0px 1px 4px #c4c3c2;
    border-radius: 8px;
    .product-background {
      width: 100%;
      position: absolute;
      height: 70%;
      top: 0;
      left: 0;
      background: #ffd8d8;
      border-top-right-radius: 8px;
      border-top-left-radius: 8px;
      z-index: -5;
    }
    img {
      width: 50px;
      height: 50px;
      border-radius: 20%;
      position: absolute;
      z-index: -1;
      left: -10%;
      top: 13px;
      transition: all 0.5s;
      box-shadow: 0px 2px 5px rgba(75, 73, 73, 0.6);

      &.activeimg {
        border-radius: 8px;
        width: 50%;
        left: 25%;
        top: 55%;
        z-index: 10;
        box-shadow: 0px 2px 5px rgba(75, 73, 73, 0.6);
        transition: all 0.5s;
      }
    }
    .text-container {
      display: flex;
      width: 80%;
      margin: 0 auto;
      flex-direction: column;
      justify-content: space-between;
      padding-left: 5px;

      h5 {
        color: black;
        font-weight: bold;
        font-size: 13px;
        margin: 0;
        &.activeH5 {
          color: #7a7a7a;
          font-size: 16px;
        }
      }
      p.price {
        color: #eb4d4b;
        margin: 0;
      }
    }
    .button {
      border-radius: 50%;
      width: 40px;
      height: 40px;
      background: white;
      font-size: 20px;
      border: none;
      color: #f53b50;
      box-shadow: 0px 2px 5px rgba(75, 73, 73, 0.6);
      position: absolute;
      z-index: 100;
      right: -20px;
      outline: none;
      display: flex;
      justify-content: center;
      justify-items: center;
      transition: all 0.5s;
      &.active {
        bottom: 0px;
        transition: all 0.5s;
        &.add-button {
          left: -20px;
          transition: all 0.5s;
        }
      }
      &.unactive {
        top: 20px;
        transition: all 0.5s;
      }
    }
    .choice-form {
      position: fixed;
      z-index: 800;
      width: 80%;
      top: 30%;
      left: 10%;
      border-radius: 3px;
      background-color: #c7eceef0;
      transition: all 0.5s;
      .choice-form-title {
        font-size: 16px;
        font-weight: bold;
        color: #1e1e1e;
        display: flex;
        justify-content: space-between;
        padding: 2px 10px;
      }
      .choice-group {
        box-shadow: 0px 2px 2px #00000094;
        padding: 8px;
        border-radius: 3px;
        background-color: #ffffff91;
        min-height: 100px;
        width: 80%;
        margin: auto;
        margin-top: 20px;
        display: flex;
        flex-direction: column;
        justify-content: space-around;
        h4 {
          font-size: 14px;
          text-align: center;
          margin: 0;
          text-shadow: 1px 1px 1px #c9c2c2;
          font-weight: bold;
        }
        ul {
          list-style-type: none;
          padding: 0;
          display: flex;
          justify-content: space-around;
          margin: 0;
          margin-bottom: 4px;
          li {
            color: black;
            vertical-align: middle;
            font-size: 11px;
            input {
              box-sizing: border-box;
              padding: 0;
              vertical-align: middle;
            }
            span {
              vertical-align: middle;
            }
          }
        }
      }
    }
    .form_button_container {
      text-align: right;
      display: flex;
      justify-content: center;
      .addButton {
        color: red;
        padding: 5px 10px;
        margin: 12px;
        background: none;
        border: none;
        display: flex;
        align-items: center;
        background: #ffbe76;
        border: 1px solid #ffbe76;
        box-shadow: 0px 0px 4px #00000040;
      }
    }
  }
  .activeProduct {
    color: black;
    height: 200px;
    h5 {
      color: white;
      font-size: 18px;
    }
    h4 {
      color: black;
    }
    p {
      max-height: none;
      float: none;
    }
  }
  h4 {
    margin-left: 5px;
    margin-top: 6px;
    margin-bottom: 0px;
    text-shadow: 1px 1px 1px #c9c2c2;
    font-weight: bold;
  }
  p.product-description {
    font-size: 8px;
    flex: 1;
    padding-top: 5px;
  }
}
</style>

