module.exports = {
  testEnvironment: "jsdom",
  transformIgnorePatterns: ["node_modules/(?!(axios)/)"],
  moduleNameMapper: {
    "\\.(css|less|scss|sass)$": "identity-obj-proxy"
  },
  reporters: [
    "default",
    ["jest-junit", {
      outputDirectory: "react-frontend/test-reports",
      outputName: "frontend-test-report.xml"
    }]
  ]
};
