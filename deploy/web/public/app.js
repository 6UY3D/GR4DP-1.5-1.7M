async function predict() {
    const file = document.getElementById('inputFile').files[0];
    const formData = new FormData();
    formData.append('data', file);
    formData.append('type', 'image'); // Simplified
    try {
        const response = await fetch('/predict', {
            method: 'POST',
            body: formData
        });
        const result = await response.json();
        document.getElementById('result').innerText = JSON.stringify(result);
    } catch (err) {
        console.error(err);
    }
}
