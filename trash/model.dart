// class FunctionType {
//   static String READ = "read";
//   static String WRITE_SINGLE = "writeSingle";
//   static String WRITE_MULTIPLE = "writeMultiple";
// }
//
// class ModbusFunctionCode {
//   int code;
//   String type;
//   ModbusFunctionCode(this.code, this.type);
//
//   static ModbusFunctionCode readCoils = ModbusFunctionCode(0x01, FunctionType.READ);
//   static ModbusFunctionCode readDiscreteInputs = ModbusFunctionCode(0x02, FunctionType.READ);
//   static ModbusFunctionCode readHoldingRegisters = ModbusFunctionCode(0x03, FunctionType.READ);
//   static ModbusFunctionCode readInputRegisters = ModbusFunctionCode(0x04, FunctionType.READ);
//   static ModbusFunctionCode writeSingleCoil = ModbusFunctionCode(0x05, FunctionType.WRITE_SINGLE);
//   static ModbusFunctionCode writeSingleHoldingRegister = ModbusFunctionCode(0x06, FunctionType.WRITE_SINGLE);
//   static ModbusFunctionCode writeMultipleCoils = ModbusFunctionCode(0x0F, FunctionType.WRITE_MULTIPLE);
//   static ModbusFunctionCode writeMultipleHoldingRegisters = ModbusFunctionCode(0x10, FunctionType.WRITE_MULTIPLE);
// }
//
// class ModbusDataType {
//   static String DISCRETE_INPUT = "discreteInput";
//   static String COIL = "coil";
//   static String INPUT_REGISTER = "inputRegister";
//   static String HOLDING_REGISTER = "holdingRegister";
// }