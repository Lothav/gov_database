<template>
  <animated-fade-in>
    <p>{{text}}</p>
  </animated-fade-in>
</template>
<script>
  export default {
    name: 'text-p',
    props: ['text'],
    data () {
      return {
      }
    }
  }
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
  h1, h2 {
    font-weight: normal;
  }
  ul {
    list-style-type: none;
    padding: 0;
  }
  li {
    display: inline-block;
    margin: 0 10px;
  }
  a {
    color: #42b983;
  }
  .description {
    text-align: left;
  }
</style>
