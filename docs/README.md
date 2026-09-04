RaceDay Platform - Part 1: System Planning & Database Design

Project Overview
RaceDay is a comprehensive web management platform designed for road race events. The system enables **Event Organisers** to publish race events, define distance categories, and manage race results, while allowing **Participants** to browse events, enroll in categories, and view their historical performance results.

Key Features & Roles
Event Organisers**: Create and manage race events, configure categories (e.g., 5km, 10km, 21km), view enrolled participants, and log official finish times.
Participants**: Register accounts, browse upcoming races, enroll in specific event categories, and track personal race results.

Part 1 Project Artifacts (`/docs`)
docs/ERD.png`: Entity Relationship Diagram illustrating the core database entities and relationships.
docs/schema.sql: Full SSMS-compatible SQL script including database initialization, table constraints, and initial seed data.
docs/api-plan.md: Detailed REST API endpoint specification mapping methods, routes, parameters, and roles.

CI/CD Validation
This repository includes an automated GitHub Actions CI workflow (`.github/workflows/part1-ci.yml`) to automatically validate repository structure, document presence, and SQL syntax on every commit.
