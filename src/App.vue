<template>
  <div id="app">
    <GameSelector 
      v-if="currentGame === ''" 
      :cards="flashcards"
      :selectedType="selectedType"
      @select="selectGame" 
      @update:selectedType="updateSelectedType"
    />
    <FlashcardGame v-if="currentGame === 'flip'" :cards="filteredCards" @back="currentGame = ''" />
    <MatchCardsGame 
      v-if="currentGame === 'match'" 
      :cards="filteredCards" 
      @back="currentGame = ''" 
    />
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
      currentGame: "",
      selectedType: "" // Empty string means "All"
    };
  },
  computed: {
    // Filter cards based on selected type
    filteredCards() {
      if (!this.selectedType || this.selectedType === "") {
        return this.flashcards; // Return all cards if no type selected
      }
      return this.flashcards.filter(card => card.type === this.selectedType);
    }
  },
  methods: {
    selectGame(game) {
      this.currentGame = game;
    },
    updateSelectedType(type) {
      this.selectedType = type;
    }
  }
};
</script>

<style>
body {
  margin: 0;
}
</style>

