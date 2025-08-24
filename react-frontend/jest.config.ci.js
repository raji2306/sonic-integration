module.exports = {
  testEnvironment: "jsdom", // For React components
  transformIgnorePatterns: ["node_modules/(?!(axios)/)"],
  moduleNameMapper: {
    "\\.(css|less|scss|sass)$": "identity-obj-proxy"
  },
  reporters: [
    "default",
    ["jest-junit", {
      outputDirectory: "./test-reports",
      outputName: "frontend-test-report.xml"
    }]
  ],
  // Optional: avoid leaving async handles open (like API calls)
  // setupFilesAfterEnv: ["<rootDir>/jest.setup.js"]
};
