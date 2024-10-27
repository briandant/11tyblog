const syntaxHighlight = require("@11ty/eleventy-plugin-syntaxhighlight");

module.exports = function (eleventyConfig) {
  // eleventyConfig.addPassthroughCopy("output.css");
  eleventyConfig.addPlugin(syntaxHighlight);
  // eleventyConfig.addLayoutAlias("note", "layouts/note.liquid");
  // eleventyConfig.addLayoutAlias("link", "layouts/link.liquid");
  // Copy the `images` directory to the output
  eleventyConfig.addPassthroughCopy("images");
};
