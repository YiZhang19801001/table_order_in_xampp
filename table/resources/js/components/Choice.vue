<template>
<ul>
    <li v-for="(choice,index) in choice_type.choices" :key="index">
        <label class="container">
            <input
            type="radio"
            :name="choice_type.type"
            :value="choice.name"
            v-model="pickedChoice"
            v-on:change="pickValue"
            >
            <span class="checkmark-wrap">
                <span class="checkmark" :style="{backgroundImage:`url(${imgURL}${choice.name}.jpg)`}"></span>

            </span>
        </label>
        <span class="choice-info">
            <span class="choice-name">{{choice.name}}</span>
            <span class="choice-price">{{parseInt(choice.price)===0?"free":choice.price}}</span>
        </span>
    </li>
</ul>


</template>

<script>
export default {
  props: {
    choice_type: {},
    index: 0
  },
  data() {
    return {
      pickedChoice: this.choice_type.choices[0].name
    };
  },
  computed: {
    imgURL() {
      return "/table/public/images/";
    }
  },
  mounted() {
    this.pickValue();
  },
  methods: {
    pickValue() {
      let id = 0;
      let choice_price = 0;
      this.choice_type.choices.forEach(ele => {
        if (ele.name === this.pickedChoice) {
          id = ele.product_ext_id;
          choice_price = ele.price;
        }
      });
      this.$emit(
        "pickValue",
        { value: this.pickedChoice, product_ext_id: id, price: choice_price },
        this.index
      );
    }
  }
};
</script>

<style lang="scss" scoped>
ul {
  display: flex;
  flex-wrap: wrap;
  li {
    display: flex;
    flex-direction: column;
    min-width: 33%;
  }
}
.container {
  margin: 0;
  display: flex;
  justify-content: center;
  padding: 0;
}
.container input {
  position: absolute;
  opacity: 0;
}
.checkmark-wrap {
  //   position: absolute;
  //   top: 0;
  //   left: 0;
  display: flex;
  height: 44px;
  width: 44px;
  z-index: 1;
  background-color: #2196f3;
  border-radius: 50%;
}
.checkmark {
  //   position: absolute;
  //   top: 2px;
  //   left: 2px;
  display: flex;
  height: 40px;
  width: 40px;

  background-size: cover;
  z-index: 2;
  border-radius: 50%;
  margin-top: 2px;
  margin-left: 2px;
}
/* When the checkbox is checked, add a blue background */
.container input:checked ~ .checkmark-wrap {
  background-color: #eb4d4b;
}
.choice-info {
  display: flex;
  flex-direction: column;
  justify-content: space-between;
}
span.choice-price {
  text-align: center;
  font-size: 12px;
  font-weight: 400;
}
.choice-name {
  text-align: center;
  font-weight: 600;
}
</style>
