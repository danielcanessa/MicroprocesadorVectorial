/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package proyecto1;

import java.util.ArrayList;

/**
 *
 * @author leoam
 */
public class RiskDetection {

    public ArrayList<String> principal(ArrayList<String> instructions) {
        String instruction;
        ArrayList<ArrayList> instructionsCharacters = new ArrayList<ArrayList>();
        ArrayList<String> characters = new ArrayList<String>();

        for (int i = 0; i < instructions.size(); i++) {
            instruction = instructions.get(i);
           // System.out.println("Instruccion: " + instruction);
            characters = getCharacters(instruction);//to get the array of characters (mnemonic, rd, rs, rt)
            instructionsCharacters.add(characters);
        }

        return riskDetection(instructionsCharacters, instructions);
    }

    public ArrayList<String> riskDetection(ArrayList<ArrayList> instructionsCharacters, ArrayList<String> instructions) {
        ArrayList<String> characters = new ArrayList<String>();
        ArrayList<String> instructionsCorrected = new ArrayList<String>();
        String mnemonic, rsActual, rtNext, rdNext, rsNext;
        int size = instructionsCharacters.size();
        int nops = 0;
        boolean flag = false;

        //System.out.println("**************************** RISK DETECTION ***************************************");
        
        for (int i = 0; i < size; i++) {
            nops = 0;
            mnemonic = "";
            rsActual = "";
            rtNext = "";
            rdNext = "";
            rsNext = "";

            characters = instructionsCharacters.get(i);
           
            //System.out.println("Characters: " + characters);

            mnemonic = characters.get(0);
            rsActual = characters.get(1);
            /*
            System.out.println("rs: " + rs);
            System.out.println("rt: " + rt);
            System.out.println("rd: " + rd);
             */

            if ((rsActual.contains("r") || rsActual.contains("v")) && mnemonic != "beq") {
                if (i + 1 < size) {
                   // System.out.println("··········································································");
                 //   System.out.println("mnemonicActual: " + mnemonic);
                  //  System.out.println("rsActual: " + rsActual);
                    characters = instructionsCharacters.get(i + 1);
                    rsNext = characters.get(1);
                    rtNext = characters.get(2);
                    rdNext = characters.get(3);

                 //   System.out.println("rsNext: " + rsNext);
                //    System.out.println("rtNext: " + rtNext);
                 //   System.out.println("rdNext: " + rdNext);

                    if (rsActual.equalsIgnoreCase(rsNext) || rsActual.equalsIgnoreCase(rtNext) || rsActual.equalsIgnoreCase(rdNext)) {
               //         System.out.println("Insertar 3 nops. Operando");
                        if (nops < 3) {
                            nops = 3; //insert 3 nops
                        }
                    }
                }

                if (i + 2 < size) {
                    characters = instructionsCharacters.get(i + 2);
               //     System.out.println("··········································································");
              //      System.out.println("mnemonicActual: " + mnemonic);
              //      System.out.println("rsActual: " + rsActual);

                    rsNext = characters.get(1);
                    rtNext = characters.get(2);
                    rdNext = characters.get(3);

             //       System.out.println("rsNext: " + rsNext);
             //       System.out.println("rtNext: " + rtNext);
             //       System.out.println("rdNext: " + rdNext);

                    if (rsActual.equalsIgnoreCase(rsNext) || rsActual.equalsIgnoreCase(rtNext) || rsActual.equalsIgnoreCase(rdNext)) {
               //
 System.out.println("Insertar 2 nops. Operando");
                        if (nops < 2) {
                            nops = 2; //insert 2 nops
                        }
                    }
                }

                if (i + 3 < size) {
                    characters = instructionsCharacters.get(i + 3);
             //       System.out.println("··········································································");
            //        System.out.println("mnemonicActual: " + mnemonic);
           //         System.out.println("rs: " + rsActual);
                    rsNext = characters.get(1);
                    rtNext = characters.get(2);
                    rdNext = characters.get(3);

            //        System.out.println("rsNext: " + rsNext);
            //        System.out.println("rtNext: " + rtNext);
            //        System.out.println("rdNext: " + rdNext);

                    if (rsActual.equalsIgnoreCase(rsNext) || rsActual.equalsIgnoreCase(rtNext) || rsActual.equalsIgnoreCase(rdNext)) {
             //           System.out.println("Insertar 1 nops. Operando");
                        if (nops < 1) {
                            nops = 1; //insert 1 nops
                        }
                    }
                }
            }
            
            if(mnemonic.equalsIgnoreCase("beq"))
                nops = 1;

            instructionsCorrected.add(instructions.get(i));
            if (nops > 0) {
                for (int j = 0; j < nops; j++) {
            //        System.out.println("Insercion de nops");
                    instructionsCorrected.add("nop");
                }
            }

        }

        return instructionsCorrected;
    }

    public ArrayList<String> getCharacters(String instruction) {
        ArrayList<String> characters = new ArrayList<String>();
        String mnemonic = "", rs = "", rt = "", rd = "";
        String[] parts;

        //System.out.println("instruccion " + instruction);
        parts = instruction.split(" ");
        mnemonic = parts[0];
        
        if(parts.length == 2){
            rs = parts[1].replace(",", "");
        }else if(parts.length == 3){
            rs = parts[1].replace(",", "");
            rt = parts[2].replace(",", "");
        }else if (parts.length == 4){
            rs = parts[1].replace(",", "");
            rt = parts[2].replace(",", "");
            rd = parts[3].replace(",", "");
        }
        
        if(mnemonic.contains("store")){//porque el destino esta al reves
            rs = parts[2].replace(",", "");
            rt = parts[1].replace(",", "");
        }
        /*
        System.out.println("ççççççççççççççççççççççççççççççççççççççççç");
        System.out.println("Instruccion " + instruction);
        System.out.println("rs: " + rs);
        System.out.println("rt: " + rt);
        System.out.println("rd: " + rd);
*/
        characters.add(mnemonic);
        characters.add(rs);
        characters.add(rt);
        characters.add(rd);

        return characters;
    }
}
