db = db.getSiblingDB('mydatabase');

db.createCollection('products');

db.products.insertMany([
  { name: 'Keyboard', price: 29.99, category: 'Electronics' },
  { name: 'Chair', price: 99.99, category: 'Furniture' },
  { name: 'Pen', price: 1.99, category: 'Stationery' }
]);
