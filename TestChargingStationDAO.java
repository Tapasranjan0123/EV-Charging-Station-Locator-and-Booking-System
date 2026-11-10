package com.evcharging.dao;

import com.evcharging.model.ChargingStation;
import java.util.List;

public class TestChargingStationDAO {

    public static void main(String[] args) {

        ChargingStationDAO dao = new ChargingStationDAO();

        try {
            List<ChargingStation> stations = dao.getAllStations();

            System.out.println("====================================");
            System.out.println("   EV CHARGING STATION SYSTEM");
            System.out.println("====================================");

            if (stations.isEmpty()) {
                System.out.println("No charging stations found.");
            }

            for (ChargingStation station : stations) {

                System.out.println("Station ID: " + station.getStationId());
                System.out.println("Station Name: " + station.getStationName());
                System.out.println("City: " + station.getCity());
                System.out.println("Address: " + station.getAddress());
                System.out.println("Charging Type: " + station.getChargingType());
                System.out.println("Price Per Unit: Rs. " + station.getPricePerUnit());
                System.out.println("Total Slots: " + station.getTotalSlots());

                System.out.println("------------------------------------");
            }

            System.out.println("Total Stations Found: " + stations.size());

        } catch (RuntimeException e) {
            System.out.println("Failed to retrieve charging stations.");
            e.printStackTrace();
        }
    }
}
