import 'package:flutter/material.dart';

class TenantConstants {
  // Validation constants
  static const int minNameLength = 2;
  static const int maxNameLength = 50;
  static const double minRentAmount = 0.0;
  static const double maxRentAmount = 100000.0;
  static const String phoneRegex = r'^\+?[0-9]{10,15}$'; // Basic phone number validation
  static const String emailRegex = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  
  // Status values
  static const String statusActive = 'Active';
  static const String statusInactive = 'Inactive';
  static const String statusPending = 'Pending';
  static const String statusAll = 'All';
  
  // Default values
  static const String defaultPG = 'Sunshine PG';
  static const String defaultStatus = 'Active';
  
  // Date format
  static const String dateFormat = 'dd/MM/yyyy';
  
  // Status colors
  static Map<String, Color> statusColors = {
    statusActive: Colors.green,
    statusPending: Colors.orange,
    statusInactive: Colors.red,
  };
  
  // Validation messages
  static const String validationNameRequired = 'Please enter full name';
  static const String validationNameLength = 'Name must be between 2 and 50 characters';
  static const String validationPhoneRequired = 'Please enter phone number';
  static const String validationPhoneInvalid = 'Please enter a valid phone number';
  static const String validationPhoneExists = 'Phone number already exists';
  static const String validationEmailRequired = 'Please enter email address';
  static const String validationEmailInvalid = 'Please enter a valid email address';
  static const String validationEmailExists = 'Email already exists';
  static const String validationRoomRequired = 'Please enter room number';
  static const String validationRoomOccupied = 'Room is already occupied';
  static const String validationRentRequired = 'Please enter monthly rent';
  static const String validationRentInvalid = 'Please enter a valid rent amount';
  static const String validationRentTooHigh = 'Rent amount seems too high';
  
  // Default PG list
  static List<String> get defaultPGs => [
    statusAll,
    'Sunshine PG',
    'Royal PG',
    'Comfort PG',
  ];
  
  // Status list
  static List<String> get statusList => [
    statusAll,
    statusActive,
    statusInactive,
    statusPending,
  ];
}
