<template>


            <form class="choice-form"  @submit.prevent="addToOrder()" ref="choices_form" key="animation-form">
                <div class="choice-form-title">Make Your Choices<p @click="closeChoiceForm"><i class="material-icons">close</i></p></div>

                <div v-for="(choice_type, index) in item.choices" class="choice-group" :key="index">
                    <h4>{{choice_type.type}}</h4>
                    <Choice :choice_type="choice_type" :index="index" @pickValue="addChoice"></Choice>
                </div>
                <div class="form_button_container"><button class="addButton" type="submit"><i class="material-icons">add_shopping_cart</i> Add to Order List</button></div>
            </form>

</template>

<script>
import { mapState, mapMutations, mapGetters, mapActions } from "vuex";
import Choice from "./Choice.vue";

export default {
  name: "app-choice-form",
  props: {
    item: {}
  },
  data() {
    return {
      pickedChoices: []
    };
  },
  methods: {
    ...mapActions(["addNewItemToOrderList"]),
    addToOrder() {
      let newItem = JSON.parse(JSON.stringify(this.item));
      newItem.choices.forEach((ele, index) => {
        ele.pickedChoice = this.pickedChoices[index];
      });
      this.pickedChoices = [];
      this.closeChoiceForm();
      this.addNewItemToOrderList(newItem);
    },
    addChoice(value, index) {
      this.pickedChoices[index] = value;
    },
    closeChoiceForm() {
      this.$emit("closeChoiceForm");
    }
  },
  components: {
    Choice
  }
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
          margin: 0;
          font-weight: 600;
          text-align: center;
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
  }
}
</style>
