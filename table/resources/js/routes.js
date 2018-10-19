import MainApp from "./components/MainApp.vue";

export const routes = [
    //<- all router configrations goes here.
    { path: "/table/public/table/:table/orderid/:orderid", component: MainApp }
];
