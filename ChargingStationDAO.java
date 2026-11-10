package com.evcharging.dao;

import com.evcharging.model.ChargingStation;
import com.evcharging.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ChargingStationDAO {

    // Get all active charging stations
    public List<ChargingStation> getAllStations() {

        List<ChargingStation> stations = new ArrayList<>();


        String sql = "SELECT station_id, station_name, city, address, " +
                "charging_type, price_per_unit, total_slots, active " +
                "FROM charging_stations " +
                "WHERE active = TRUE " +
                "ORDER BY station_id";


        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement statement =
                        connection.prepareStatement(sql);
                ResultSet resultSet = statement.executeQuery()
        ) {

            while (resultSet.next()) {

                ChargingStation station = new ChargingStation();

                station.setStationId(
                        resultSet.getInt("station_id")
                );

                station.setStationName(
                        resultSet.getString("station_name")
                );

                station.setCity(
                        resultSet.getString("city")
                );

                station.setAddress(
                        resultSet.getString("address")
                );

                station.setChargingType(
                        resultSet.getString("charging_type")
                );

                station.setPricePerUnit(
                        resultSet.getBigDecimal("price_per_unit")
                );

                station.setTotalSlots(
                        resultSet.getInt("total_slots")
                );

                station.setActive(
                        resultSet.getBoolean("active")
                );

                stations.add(station);
            }

        } catch (SQLException e) {

            throw new RuntimeException(
                    "Error retrieving charging stations from database.",
                    e
            );
        }

        return stations;
    }  


    // Get one charging station by its ID
    public ChargingStation getStationById(int stationId) {

        String sql = "SELECT station_id, station_name, city, address, " +
                "charging_type, price_per_unit, total_slots, active " +
                "FROM charging_stations " +
                "WHERE station_id = ?";

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setInt(1, stationId);

            try (ResultSet resultSet = statement.executeQuery()) {

                if (resultSet.next()) {

                    ChargingStation station = new ChargingStation();

                    station.setStationId(
                            resultSet.getInt("station_id")
                    );

                    station.setStationName(
                            resultSet.getString("station_name")
                    );

                    station.setCity(
                            resultSet.getString("city")
                    );

                    station.setAddress(
                            resultSet.getString("address")
                    );

                    station.setChargingType(
                            resultSet.getString("charging_type")
                    );

                    station.setPricePerUnit(
                            resultSet.getBigDecimal("price_per_unit")
                    );

                    station.setTotalSlots(
                            resultSet.getInt("total_slots")
                    );

                    station.setActive(
                            resultSet.getBoolean("active")
                    );

                    return station;
                }
            }

        } catch (SQLException e) {

            throw new RuntimeException(
                    "Error retrieving charging station by ID.",
                    e
            );
        }

        return null;
    }
}

