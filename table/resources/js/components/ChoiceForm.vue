<template>


            <form class="choice-form animated zoomInDown" id="choiceForm"  @submit.prevent="addToOrder()" key="animation-form">
                <!-- header -->
                <div class="choice-form-title">{{app_conf.choice_form_title}}<p @click="closeForm"><i class="material-icons">close</i></p></div>
                <!-- header end -->

                <!-- choice & option summary -->
                <div v-if="pickedChoices.length > 0 || pickedOptions.length >0" class="summary">
                    <div v-for="(choice_type,index) in item.choices" class="choice-summary" :key="index">
                        <span class="summary-title">{{choice_type.type}} : </span>
                        <span>{{this.pickedChoices[index]}}</span>
                    </div>
                    <div v-for="(option,index2) in item.options" class="choice-summary" :key="index2">
                        <span class="summary-title">{{option.option_name}} : </span> <span class="summary-value">{{this.pickedOptions[index2]}}</span>
                    </div>
                </div>
                <!-- choice & option summary end-->

                <div class="detail-contianer">
                    <!-- product_ext -->
                    <div v-for="(choice_type, index) in item.choices" class="choice-group" :key="`ext${index}`">
                        <h4>{{choice_type.type}}</h4>
                        <Choice :choice_type="choice_type" :index="index" @pickValue="addChoice"></Choice>
                    </div>
                    <!-- product_ext end -->

                    <!-- option  -->
                    <div v-for="(option, index2) in item.options" class="choice-group" :key="`opt${index2}`">
                        <h4>{{option.option_name}}</h4>
                        <Option :option="option" :index="index2" @pickValue="addOption"></Option>
                    </div>
                    <!-- option end -->
                </div>

                <!-- confirm button -->
                <div class="form_button_container">
                    <button class="addButton" type="submit">
                        <i class="material-icons">add_shopping_cart</i> {{app_conf.choice_form_button}}
                    </button>
                </div>
                <!-- confirm button end -->
            </form>

</template>

<script>
import { mapState, mapMutations, mapGetters, mapActions } from "vuex";
import Choice from "./Choice.vue";
import Option from "./Option.vue";

export default {
  name: "app-choice-form",
  props: {
    item: {}
  },
  data() {
    return {
      pickedChoices: [],
      pickedOptions: []
    };
  },
  computed: {
    ...mapGetters(["app_conf"])
  },
  mounted() {},
  methods: {
    ...mapActions(["addNewItemToOrderList", "setFormClass"]),
    addToOrder() {
      let newItem = JSON.parse(JSON.stringify(this.item));
      newItem.choices.forEach((ele, index) => {
        ele.pickedChoice = this.pickedChoices[index].value;
        ele.product_ext_id = this.pickedChoices[index].product_ext_id;
        ele.price = this.pickedChoices[index].price;
      });
      newItem.options.forEach((ele, index) => {
        ele.pickedOption = this.pickedOptions[index].value;
        ele.product_option_value_id = this.pickedOptions[
          index
        ].product_option_value_id;
        ele.price = this.pickedOptions[index].price;
      });
      this.pickedChoices = [];
      this.pickedOptions = [];

      document.getElementById("choiceForm").className =
        "choice-form animated zoomOutDown";

      this.delay(800).then(res => {
        this.closeChoiceForm();
        this.addNewItemToOrderList(newItem);
      });
    },
    addChoice(value, index) {
      this.pickedChoices[index] = value;
    },
    addOption(value, index) {
      this.pickedOptions[index] = value;
    },
    closeForm() {
      document.getElementById("choiceForm").className =
        "choice-form animated zoomOut";

      this.delay(300).then(res => {
        this.closeChoiceForm();
      });
    },
    closeChoiceForm() {
      this.$emit("closeChoiceForm");
    },
    delay(time) {
      return new Promise(resolve => {
        setTimeout(() => {
          resolve("resolved");
        }, time);
      });
    }
  },
  components: {
    Choice,
    Option
  }
};
</script>
<style lang="scss" scoped>
.detail-contianer {
  min-height: 180px;
  max-height: 250px;
  overflow: scroll;
}
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
  width: 70%;
  box-shadow: 0px 2px 3px #00000038;
  padding: 0px 5px;

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
        border-top-left-radius: 8px;
        border-top-right-radius: 8px;
        border-bottom-left-radius: 0px;
        border-bottom-right-radius: 0px;
        width: 100%;
        height: 75%;
        left: 0;
        top: 0;
        box-shadow: none;
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
        margin-bottom: 8px;
        &.activeH5 {
          color: white;
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
      &.active {
        bottom: 0px;
        &.add-button {
          right: 30px;
        }
      }
      &.unactive {
        top: 20px;
      }
    }
    .choice-form {
      position: fixed;
      z-index: 800;
      width: 80%;
      top: 30%;
      left: 10%;
      border-radius: 8px;
      background-color: #fff;
      transition: all 0.5s;
      .choice-form-title {
        font-size: 16px;
        font-weight: bold;
        color: #ffffff;
        text-shadow: 0px 1px 1px black;
        display: flex;
        justify-content: space-between;
        padding: 2px 10px;
        background-color: rgb(235, 77, 75);
        border-top-left-radius: 8px;
        border-top-right-radius: 8px;
      }
      .choice-group {
        box-shadow: 0px 2px 2px #00000094;
        padding: 8px;
        border-radius: 8px;
        background-color: rgba(190, 191, 192, 0.25);
        min-height: 155px;
        max-height: 160px;
        overflow: scroll;
        width: 80%;
        margin: auto;
        margin-top: 20px;
        margin-bottom: 20px;
        display: flex;
        flex-direction: column;
        justify-content: space-around;
        h4 {
          font-size: 16px;
          color: #000;
          margin: 0;
          font-weight: 900;
          text-align: center;
          margin-bottom: 8px;
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
              font-size: 12px;
              font-weight: 800;
              color: white;
              text-shadow: 0px 1px 1px black;
            }
          }
        }
      }
    }
    .form_button_container {
      text-align: right;
      display: flex;
      justify-content: center;
      position: relative;
      height: 30px;
      .addButton {
        color: #fff;
        padding: 5px 10px;
        border: none;
        display: -webkit-box;
        display: -ms-flexbox;
        display: flex;
        align-items: center;
        background: #ffc24a;
        box-shadow: 0px 5px 5px #00000038;
        text-shadow: 1px 1px 2px black;
        letter-spacing: 0.6px;
        border-radius: 8px;
        position: fixed;
        width: 60%;
        display: flex;
        justify-content: center;
        left: 20%;
        margin: 12px 0px;
      }
    }
  }
  .activeProduct {
    color: black;
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
      margin: 0;
    }
  }
  h4 {
    margin-left: 5px;
    margin-top: 6px;
    margin-bottom: 0px;
  }
}
</style>
