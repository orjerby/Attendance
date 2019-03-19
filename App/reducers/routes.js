export default (state = ["Home"], action) => {
  let newRoutes = [];
  switch (action.type) {
    case "PUSH_ROUTE":
      newRoutes = [...state, action.routeName];
      return Array.from(new Set(newRoutes));
    case "POP_ROUTE":
      let oldRoutes = state;
      oldRoutes.pop();
      newRoutes = [...oldRoutes];
      return newRoutes;
    case "CLEAR_ROUTES":
      return ["Home"];
    default:
      return state;
  }
};
