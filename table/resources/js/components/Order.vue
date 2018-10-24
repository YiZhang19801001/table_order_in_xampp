<template>
<div>

    <Head></Head>
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
.bodyContainer {
  display: flex;
  flex-direction: row;
}
</style>

