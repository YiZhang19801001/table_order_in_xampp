require("./bootstrap");
import Vue from "vue";
import VueRouter from "vue-router";
import Vuex from "vuex";
import { routes } from "./routes";
import MainApp from "./components/MainApp.vue";
import DeskApp from "./components/DeskApp.vue";
import Scrollspy from "vue2-scrollspy";
//import store
import StoreData from "./store.js";

Vue.use(VueRouter);
Vue.use(Vuex);
Vue.use(Scrollspy);

//declare the store const for use in different component
const store = new Vuex.Store(StoreData);

const router = new VueRouter({
    routes,
    mode: "history"
});

const app = new Vue({
    el: "#app",
    router,
    store,
    components: {
        MainApp,
        DeskApp
    }
});
