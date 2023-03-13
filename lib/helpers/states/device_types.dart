enum DeviceTypes {
  DIGITAL_OUTPUT_1,
  DIGITAL_OUTPUT_2,
  DIGITAL_OUTPUT_3,
  DIGITAL_OUTPUT_4,
  DIGITAL_OUTPUT_5,
  ANALOG_OUTPUT_1,
  ANALOG_OUTPUT_2,
  ANALOG_OUTPUT_3,
  ANALOG_OUTPUT_4,
}

extension Types on DeviceTypes {
  String get getKey {
    switch (this) {
      case DeviceTypes.DIGITAL_OUTPUT_1:
        return "DO1";
      case DeviceTypes.DIGITAL_OUTPUT_2:
        return "DO2";
      case DeviceTypes.DIGITAL_OUTPUT_3:
        return "DO3";
      case DeviceTypes.DIGITAL_OUTPUT_4:
        return "DO4";
      case DeviceTypes.DIGITAL_OUTPUT_5:
        return "DO5";
      case DeviceTypes.ANALOG_OUTPUT_1:
        return "AO1";
      case DeviceTypes.ANALOG_OUTPUT_2:
        return "AO2";
      case DeviceTypes.ANALOG_OUTPUT_3:
        return "AO3";
      case DeviceTypes.ANALOG_OUTPUT_4:
        return "AO4";
    }
  }

  String get getName {
    switch (this) {
      case DeviceTypes.DIGITAL_OUTPUT_1:
        return "Digital output 1";
      case DeviceTypes.DIGITAL_OUTPUT_2:
        return "Digital output 2";
      case DeviceTypes.DIGITAL_OUTPUT_3:
        return "Digital output 3";
      case DeviceTypes.DIGITAL_OUTPUT_4:
        return "Digital output 4";
      case DeviceTypes.DIGITAL_OUTPUT_5:
        return "Digital output 5";
      case DeviceTypes.ANALOG_OUTPUT_1:
        return "Analog output 1";
      case DeviceTypes.ANALOG_OUTPUT_2:
        return "Analog output 2";
      case DeviceTypes.ANALOG_OUTPUT_3:
        return "Analog output 3";
      case DeviceTypes.ANALOG_OUTPUT_4:
        return "Analog output 4";
    }
  }


}
