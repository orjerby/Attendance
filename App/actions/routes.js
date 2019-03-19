export const pushRoute = routeName => ({
  type: "PUSH_ROUTE",
  routeName
});

export const popRoute = () => ({
  type: "POP_ROUTE"
});

export const clearRoutes = () => ({
  type: "CLEAR_ROUTES"
});
