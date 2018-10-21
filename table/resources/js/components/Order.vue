<template>
<div>

    <Head class="header"></Head>
    <div class="bodyContainer">
        <CategoryList></CategoryList>
        <ProductList></ProductList>
        <ShoppingCart></ShoppingCart>
    </div>
</div>

</template>

<script>
import CategoryList from "./CategoryList";
import ProductList from "./ProductList";
import ShoppingCart from "./ShoppingCart";
import Head from "./Head";
export default {
  components: { CategoryList, ProductList, Head, ShoppingCart }
};
</script>

<style lang="scss" scoped>
.header {
  position: fixed;
  width: 100%;
  background-color: #f53b50;
  color: white;
  text-align: center;
  padding: 6px;
  box-shadow: 0px 5px 5px #00000038;
  z-index: 200;
}
.bodyContainer {
  display: flex;
  flex-direction: row;
}
</style>

