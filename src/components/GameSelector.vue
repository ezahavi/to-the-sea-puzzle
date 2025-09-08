<template>
  <div class="menu">
    <!-- Type selector at the top -->
    <div class="type-selector-container">
      <h1 class="selector-title">Select Cards Type</h1>
      <select id="cardTypeSelect" v-model="currentType" @change="updateType">
        <option value="">All</option>
        <option
          v-for="t in availableTypes"
          :key="t"
          :value="t"
        >{{ t }}</option>
      </select>
    </div>
    
    <h1>Select a Game</h1>
    <button @click="$emit('select', 'flip')">Flip Cards</button>
    <button @click="$emit('select', 'match')">Match Cards</button>
  </div>
</template>

<script>
export default {
  name: "GameSelector",
  props: {
    selectedType: {
      type: String,
      default: ""
    },
    cards: {
      type: Array,
      required: true
    }
  },
  data() {
    return {
      currentType: this.selectedType,
      availableTypes: []
    };
  },
  watch: {
    selectedType(newVal) {
      this.currentType = newVal;
    }
  },
  created() {
    // Extract unique card types from the cards array
    this.availableTypes = [...new Set(this.cards.map(c => c.type))].sort();
  },
  methods: {
    updateType() {
      this.$emit('update:selectedType', this.currentType);
    }
  }
};
</script>

<style scoped>
.menu {
  display: flex;
  flex-direction: column;
  align-items: center;
  margin-top: 50px;
}

.type-selector-container {
  display: flex;
  flex-direction: column;  /* Stack label above selector */
  align-items: center;
  gap: 10px;  /* Reduced gap for vertical layout */
  margin-bottom: 30px;
}

.type-selector-container .selector-title {
  margin: 10px 0;  /* Consistent spacing */
}

.type-selector-container select {
  font-size: 20px;  /* Slightly larger than buttons for better readability */
  padding: 12px 22px;  /* Slightly more padding to match larger font */
  margin: 10px;  /* Same margin as buttons */
  /* Match button appearance from styles.css */
  background-color: #3eaf7c;  /* Green like buttons */
  color: white;  /* White text like buttons */
  border: none;  /* No border like buttons */
  border-radius: 4px;  /* Same radius as buttons */
  cursor: pointer;
  min-width: 150px;
  font-family: inherit;  /* Use same font as buttons */
  transition: background-color 0.2s ease;  /* Same transition as buttons */
}

.type-selector-container select:hover {
  background-color: #349968;  /* Darker green on hover like buttons */
}

.type-selector-container select:focus {
  outline: none;
  box-shadow: 0 0 0 2px rgba(62, 175, 124, 0.3);  /* Focus ring */
}

/* Style the dropdown options */
.type-selector-container select option {
  background-color: white;
  color: black;
}

button {
  margin: 10px;
  padding: 10px 20px;
  font-size: 18px;
  cursor: pointer;
}
</style>

