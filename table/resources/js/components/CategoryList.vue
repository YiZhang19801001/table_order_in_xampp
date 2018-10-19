<template>
    <div class="listContainer">
        <div class="categoryContainer" v-scroll-spy-active v-scroll-spy-link>
            <div v-for="category in categoryList" :key="category.category_id" class="categoryList"
            :class="{customActive:category.category_id===selectId}"
            @click="select(category.category_id)">
               <a>{{category.name}}</a>
            </div>
        </div>
    </div>
</template>

<script>
import { mapGetters, mapMutations, mapActions, mapState } from "vuex";
export default {
  name: "app-category-list",
  data() {
    return {
      selectId: 0
    };
  },
  computed: {
    ...mapGetters(["categoryList"])
  },
  mounted() {
    this.getCategoryList();
  },
  methods: {
    ...mapMutations(["updateCategoryList"]),
    ...mapActions(["getCategoryList"]),
    select(id) {
      this.selectId = id;
    }
  }
};
</script>

<style lang="scss" scoped>
.listContainer {
  margin-top: 45px;
  justify-content: space-between;
  display: flex;
  height: 80vh;
  width: 30%;
  flex-direction: column;
  position: relative;
  .categoryContainer {
    position: fixed;
    width: 27%;
    .categoryList {
      padding: 5px 10px;
      color: white;
      background-color: #eb4d4b;
      border-bottom: 1px solid #80808026;
      transition: all 0.5s;
    }
    .customActive {
      color: #ff7979;
      text-align: center;
      background-color: #dff9fb;
      transform: scale(1.1);
      box-shadow: -1px 2px 3px #00000038;
    }
  }
}
</style>

