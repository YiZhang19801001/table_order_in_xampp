import Payment from "./components/Payment.vue";
import Order from "./components/Order.vue";
import Menu from "./components/Menu.vue";
import Confirm from "./components/Confirm.vue";

export const routes = [
    //<- all router configrations goes here.
    {
        path: "/table/public/table/:table/orderid/:orderid",
        component: Order
    },
    {
        path: "/table/public/table/:table/orderid/:orderid/payment",
        component: Payment
    },
    {
        path: "/table/public/confirm",
        component: Confirm
    },
    {
        path: "/table/public/menu",
        component: Menu
    }
];
