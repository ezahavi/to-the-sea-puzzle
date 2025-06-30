<template>
  <div class="menu">
    <h1>Select a Game</h1>
    <button @click="$emit('select', 'flip')">Flip Cards</button>
    <button @click="$emit('select', 'match')">Match Cards</button>
  </div>
</template>

<script>
export default {
  name: "GameSelector"
};
</script>

<style scoped>
.menu {
  display: flex;
  flex-direction: column;
  align-items: center;
  margin-top: 50px;
}
button {
  margin: 10px;
  padding: 10px 20px;
  font-size: 18px;
  cursor: pointer;
}
</style>

