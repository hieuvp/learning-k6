// https://k6.io/docs/using-k6/options/
// Options allow you to configure how k6 will behave during test execution

{
  // Virtual Users (VUs)
  vus: 5,

  stages: [
    // Specify the target number of VUs to ramp up or down to for a specific period
    { duration: '10s', target: 10 },
    { duration: '10s', target: 20 },
    { duration: '10s', target: 0 },
  ],
}
