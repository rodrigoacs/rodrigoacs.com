const Sequelize = require("sequelize");

const sequelize = new Sequelize('hoursapp', 'root', 'sql1405', {
  host: "localhost",
  dialect: "mysql"
})

sequelize.sync({ force: true })

module.exports = {
  Sequelize: Sequelize,
  sequelize: sequelize
}