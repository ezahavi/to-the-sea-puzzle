<template>
  <div class="match-container">
    <div class="button-bar">
      <button @click="$emit('back')">Back to Menu</button>
      <button @click="nextBatch">Next</button>
    </div>
    <h2>Match the descriptions to the images</h2>

    <div class="match-columns">
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
          <div class="image-id">#{{ card.id }}</div>
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
    </div>
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

.button-bar {
  display: flex;
  gap: 10px;
  margin-bottom: 15px;
}

.match-columns {
  display: flex;
  justify-content: center;
  align-items: flex-start;
  gap: 20px;
  flex-wrap: wrap; /* allows stacking on small screens */
}

/* Columns */
.cards,
.descriptions {
  display: flex;
  flex-direction: column;
  gap: 10px;
}

/* Card styles */
.image-card,
.description-card {
  border: 2px solid #333;
  border-radius: 6px;
  padding: 10px;
  width: 140px;
  height: 140px;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  transition: background-color 0.3s ease, border-color 0.3s ease;
}

/* Smaller cards on mobile */
@media (max-width: 600px) {
  .image-card,
  .description-card {
    width: 100px;
    height: 100px;
  }
  .desc-card-text,
  .desc-card-id,
  .image-id {
    font-size: 12px;
  }
}

/* Matched state */
.image-card.matched,
.description-card.matched {
  border-color: green;
  background-color: #c8e6c9;
}

.image-card img {
  max-width: 100%;
  max-height: 100%;
}

.image-id {
  font-size: 14px;
  margin-top: 4px;
  color: #555;
}

.description-card {
  cursor: grab;
  text-align: center;
}

.desc-card-id {
  font-weight: bold;
  margin-bottom: 5px;
}

.desc-card-text {
  font-size: 16px;
}

button {
  margin: 5px;
}
</style>
