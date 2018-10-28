<template>
<ul>
    <li v-for="(option_value,index) in option.option_values" :key="index">
        <label class="container">
            <input
            type="radio"
            :name="option.option_name"
            :value="option_value.option_value_name"
            v-model="pickedOption"
            v-on:change="pickValue"
            >
            <span class="checkmark-wrap">
                <span class="checkmark" :style="{backgroundImage:`url(${imgURL}${option_value.option_value_name}.jpg)`}"></span>
            </span>
        </label>
        <span class="choice-info">
            <span class="choice-name">{{option_value.option_value_name}}</span>
            <span class="choice-price">{{parseInt(option_value.price)===0?"free":option_value.price}}</span>
        </span>
    </li>
</ul>

</template>

<script>
export default {
  props: {
    option: {},
    index: 0
  },
  data() {
    return {
      pickedOption: this.option.option_values[0].option_value_name,
      imgURL: "/table/public/images/"
    };
  },
  mounted() {
    this.pickValue();
  },
  methods: {
    pickValue() {
      let id = 0;
      let choice_price = 0;
      this.option.option_values.forEach(ele => {
        if (ele.option_value_name === this.pickedOption) {
          id = ele.product_option_value_id;
          choice_price = ele.price;
        }
      });
      this.$emit(
        "pickValue",
        {
          value: this.pickedOption,
          product_option_value_id: id,
          price: choice_price
        },
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
