<template>
  <div class="container">
    <h2>Click on the card to show the other side</h2>
    <div class="card" @click="flipCard">
      <div v-if="flipped" class="description">
        <div class="card-id">#{{ currentCard.id }}</div>
        <div class="card-text">{{ currentCard.description }}</div>
      </div>
      <img v-else :src="currentCard.image" alt="Flashcard image" class="image" />
    </div>
    <button @click="nextCard">Next</button>
    <button @click="$emit('back')">Back to Menu</button>
  </div>
</template>

<script>
export default {
  name: "FlashcardGame",
  props: ["cards"],
  data() {
    return {
      shuffledCards: [],
      index: 0,
      flipped: false
    };
  },
  computed: {
    currentCard() {
      return this.shuffledCards[this.index];
    }
  },
  methods: {
    flipCard() {
      this.flipped = !this.flipped;
    },
    nextCard() {
      this.flipped = false;
      this.index = (this.index + 1) % this.shuffledCards.length;
    },
    shuffle(array) {
      const copy = [...array];
      for (let i = copy.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        [copy[i], copy[j]] = [copy[j], copy[i]];
      }
      return copy;
    }
  },
  created() {
    this.shuffledCards = this.shuffle(this.cards);
  }
};
</script>

<style scoped>
.container {
  display: flex;
  flex-direction: column;
  align-items: center;
  margin-top: 30px;
}
.card {
  width: 300px;
  height: 200px;
  border: 2px solid #333;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  margin-bottom: 20px;
  background: #f8f8f8;
  text-align: center;
}
.description {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  text-align: center;
  padding: 10px;
}
.card-id {
  font-weight: bold;
  margin-bottom: 5px;
}
.card-text {
  font-size: 18px;
}
.image {
  max-width: 100%;
  max-height: 100%;
}
button {
  margin: 5px;
}
</style>
