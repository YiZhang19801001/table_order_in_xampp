<template>
    <div class="listContainer" v-scroll-spy-active v-scroll-spy-link>
        <div class="categoryContainer">
            <div v-for="(category,index) in categoryList" :key="index" class="categoryList"
            :class="{customActive:index===scrollPositionId}"
            @click="select(index)">
               <a>{{category.name}}</a>
            </div>
        </div>
    </div>
</template>

<script>
import { mapGetters, mapMutations, mapActions, mapState } from "vuex";
export default {
  name: "app-category-list",
  computed: {
    ...mapGetters(["categoryList", "scrollPositionId"])
  },
  mounted() {
    this.getCategoryList();
  },
  methods: {
    ...mapMutations(["updateCategoryList"]),
    ...mapActions(["getCategoryList", "setScrollPositionId"]),
    select(index) {
      this.setScrollPositionId(index);
      //var name = $(this).attr("data-row-id");
      //var id = "#" + name;
      //var top = $(id).first().offset().top -60;
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
    overflow: scroll;
    height: 80vh;
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

