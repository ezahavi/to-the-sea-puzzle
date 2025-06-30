<template>
  <div class="match-container">
    <h2>Match the descriptions to the images</h2>
    <div class="cards">
      <div
        v-for="card in currentImageCards"
        :key="card.id"
        class="image-card"
        :class="{ matched: matchedIds.includes(card.id) }"
        @dragover.prevent
        @drop="handleDrop(card)"
      >
        <img :src="card.image" alt="Card Image" />
      </div>
    </div>

    <div class="descriptions">
      <div
        v-for="card in currentDescriptionCards"
        :key="card.id"
        class="description-card"
        draggable="true"
        @dragstart="handleDragStart(card)"
        :class="{ matched: matchedIds.includes(card.id) }"
      >
          <div class="desc-card-id">#{{ card.id }}</div>
          <div class="desc-card-text">{{ card.description }}</div>
      </div>
    </div>
    <button @click="nextBatch">Next</button>
    <button @click="$emit('back')">Back to Menu</button>
  </div>
</template>

<script>
export default {
  name: "MatchCardsGame",
  props: ["cards"],
  data() {
    const shuffled = this.shuffle([...this.cards]);
    return {
      allCards: shuffled,
      currentIndex: 0,
      draggedCard: null,
      matchedIds: []
    };
  },
  computed: {
    currentBatch() {
      return this.allCards.slice(this.currentIndex, this.currentIndex + 4);
    },
    currentImageCards() {
      return this.currentBatch;
    },
    currentDescriptionCards() {
      return this.shuffle([...this.currentBatch]);
    }
  },
  methods: {
    handleDragStart(card) {
      this.draggedCard = card;
    },
    handleDrop(targetCard) {
      if (this.draggedCard && this.draggedCard.id === targetCard.id) {
        this.matchedIds.push(targetCard.id);
      }
      this.draggedCard = null;
    },
    nextBatch() {
      this.matchedIds = [];
      if (this.currentIndex + 4 >= this.allCards.length) {
        this.currentIndex = 0;
      } else {
        this.currentIndex += 4;
      }
    },
    shuffle(array) {
      for (let i = array.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        [array[i], array[j]] = [array[j], array[i]];
      }
      return array;
    }
  },
  created() {
    this.allCards = this.shuffle([...this.cards]);
  }
};
</script>

<style scoped>
.match-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  margin-top: 20px;
}
.cards,
.descriptions {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  margin: 20px 0;
}
.image-card,
.description-card {
  border: 2px solid #333;
  border-radius: 6px;
  margin: 10px;
  padding: 10px;
  width: 140px;
  height: 140px;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: background-color 0.3s ease, border-color 0.3s ease;
}
.image-card.matched,
.description-card.matched {
  border-color: green;
  background-color: #c8e6c9;
}
.image-card img {
  max-width: 100%;
  max-height: 100%;
}
.description-card {
  cursor: grab;
  display: flex;
  flex-direction: column;       /* vertical stacking */
  align-items: center;          /* center horizontally */
  justify-content: center;      /* center vertically */
  text-align: center;           /* center text */
  padding: 10px;
}
.desc-card-id {
  font-weight: bold;
  margin-bottom: 5px;           /* spacing under the ID */
}
.desc-card-text {
  font-size: 16px;
}
button {
  margin: 5px;
}
</style>
