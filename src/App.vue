<template>
  <div id="app">
    <GameSelector v-if="currentGame === ''" @select="selectGame" />
    <FlashcardGame v-if="currentGame === 'flip'" :cards="flashcards" @back="currentGame = ''" />
    <MatchCardsGame v-if="currentGame === 'match'" :cards="flashcards" @back="currentGame = ''" />
  </div>
</template>

<script>
import { flashcards } from "./flashcards";
import GameSelector from "./components/GameSelector.vue";
import FlashcardGame from "./components/FlashcardGame.vue";
import MatchCardsGame from "./components/MatchCardsGame.vue";

export default {
  name: "App",
  components: {
    GameSelector,
    FlashcardGame,
    MatchCardsGame
  },
  data() {
    return {
      flashcards,
      currentGame: ""
    };
  },
  methods: {
    selectGame(game) {
      this.currentGame = game;
    }
  }
};
</script>

<style>
body {
  margin: 0;
}
</style>

