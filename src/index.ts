import express, { Application, Express } from "express";

const app: Application = express();

app.get("/", (req, res) => {
  res.send("Hello World!");
});

app.get("/api/:id", (req, res) => {
  const ID = req.params.id;
  res.send(`ID ${ID}`);
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
