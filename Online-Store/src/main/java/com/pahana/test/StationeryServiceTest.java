package com.pahana.test;

import com.pahana.bookshop.model.Stationery;
import com.pahana.bookshop.service.StationeryService;
import org.junit.jupiter.api.*;

import java.sql.SQLException;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@TestInstance(TestInstance.Lifecycle.PER_CLASS)
public class StationeryServiceTest {

    private StationeryService service;

    @BeforeAll
    public void setup() {
        service = StationeryService.getInstance();
    }

    private void printStationery(Stationery s) {
        System.out.println("ID=" + s.getId() +
                " | Name=" + s.getName() +
                " | Description=" + s.getDescription() +
                " | Price=" + s.getPrice() +
                " | Qty=" + s.getQuantity());
    }

    @Test
    public void testAddStationery() throws SQLException {
        Stationery s = new Stationery();
        s.setName("Test Pen");
        s.setDescription("Blue ink pen");
        s.setPrice(50.0);
        s.setQuantity(100);

        service.addStationery(s);
        List<Stationery> all = service.getAllStationery();
        assertTrue(all.stream().anyMatch(st -> st.getName().equals("Test Pen")));

        System.out.println("Added Stationery successfully!");
    }

    @Test
    public void testGetStationeryById() throws SQLException {
        List<Stationery> all = service.getAllStationery();
        assertFalse(all.isEmpty());

        Stationery s = service.getStationeryById(all.get(0).getId());
        assertNotNull(s);

        System.out.println("Fetched Stationery by ID:");
        printStationery(s);
    }

    @Test
    public void testUpdateStationery() throws SQLException {
        List<Stationery> all = service.getAllStationery();
        assertFalse(all.isEmpty());

        Stationery s = all.get(0);
        double oldPrice = s.getPrice();
        s.setPrice(oldPrice + 20);

        service.updateStationery(s);

        Stationery updated = service.getStationeryById(s.getId());
        assertEquals(oldPrice + 20, updated.getPrice());

        System.out.println("Updated Stationery:");
        printStationery(updated);
    }

    @Test
    public void testDeleteStationery() throws SQLException {
        Stationery s = new Stationery();
        s.setName("Delete Me");
        s.setDescription("Temporary Item");
        s.setPrice(10.0);
        s.setQuantity(5);

        service.addStationery(s);
        List<Stationery> all = service.getAllStationery();
        Stationery last = all.get(all.size() - 1);

        service.deleteStationery(last.getId());
        Stationery deleted = service.getStationeryById(last.getId());
        assertNull(deleted);

        System.out.println("Deleted Stationery ID=" + last.getId());
    }

    @Test
    public void testGetAllStationery() throws SQLException {
        List<Stationery> all = service.getAllStationery();
        assertNotNull(all);
        assertTrue(all.size() > 0);

        System.out.println("------ All Stationery Items ------");
        all.forEach(this::printStationery);
        System.out.println("---------------------------------");
    }
}
