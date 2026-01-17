#!/bin/zsh

# Exit immediately if a command exists with a non-zero status
set -e

echo "=============================="
echo "✅ Starting Flutter Project Maintenance"
echo "=============================="

# Step 1: Format Dart Code
echo "🔹 Formatting Dart code..."
dart format lib test
echo "✅ Code formatted!"

# Step 2: Analyze code (lint & warnings)
echo "Running flutter analyze...."
flutter analyze
echo "Analysis complete !"

#Step 3: Run test cases
echo "🔹 Running tests..."
flutter test --coverage
echo "✅ All tests passed!"

# Step 4: Generate coverage report
echo "🔹 Generating coverage report..."
# Install lcov if not installed
if ! command -v genhtml &> /dev/null
then
    echo "⚠️ genhtml not found, installing lcov..."
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo apt-get update && sudo apt-get install -y lcov
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew install lcov
    else
        echo "⚠️ Please install lcov manually!"
    fi
fi

if [ -f coverage/lcov.info ]; then
    genhtml coverage/lcov.info -o coverage/html
    echo "✅ Coverage report generated at coverage/html/index.html"
else
    echo "⚠️ Coverage file not found"
fi

echo "=============================="
echo "🎉 Flutter project checks completed successfully!"
echo "=============================="