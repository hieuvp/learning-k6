import commonjs from "@rollup/plugin-commonjs";

export default {
  input: "./script.js",
  output: {
    file: "./dist/test.js",
    format: "es",
  },
  plugins: [commonjs()],
};
