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
            characters = getCharacters(instruction);//to get the array of characters (mnemonic, rd, rs, rt)
            instructionsCharacters.add(characters);
        }
        
        return riskDetection(instructionsCharacters, instructions);
    }
    
    public ArrayList<String> riskDetection (ArrayList<ArrayList> instructionsCharacters, ArrayList<String> instructions){
        ArrayList<String> characters = new ArrayList<String>();
        ArrayList<String> instructionsCorrected = new ArrayList<String>();
        String mnemonic, rs, rt, rd;
        int size = instructionsCharacters.size();
        int nops = 0;
        
        //System.out.println("**************************** RISK DETECTION ***************************************");
        for (int i = 0; i < size; i++) {
            nops = 0;
            characters = instructionsCharacters.get(i);
            //System.out.println(characters);
            
            mnemonic = characters.get(0);
            rs = characters.get(1);
            rt = characters.get(2);
            rd = characters.get(3);
            /*
            System.out.println("rs: " + rs);
            System.out.println("rt: " + rt);
            System.out.println("rd: " + rd);
            */
            if(i + 1 < size){
                characters = instructionsCharacters.get(i + 1);
                if(rs.equalsIgnoreCase(characters.get(1))){//Revisar si el siguiente destino (rs) es igual
                    //System.out.println("Insertar 4 nops. Destino");
                    nops = 4; //insert 4 nops
                }
                
                if(rs.equalsIgnoreCase(characters.get(2)) || rs.equalsIgnoreCase(characters.get(3))){//Revisar si el siguiente operando (rt, rd) es igual
                    //System.out.println("Insertar 3 nops. Operando");
                    if(nops < 3)
                        nops = 3; //insert 3 nops
                }
                
            } 
            
            if(i + 2 < size){
                characters = instructionsCharacters.get(i + 2);
                if(rs.equalsIgnoreCase(characters.get(1))){//Revisar si el siguiente destino (rs) es igual
                    //System.out.println("Insertar 3 nops");
                    nops = 3; //insert 3 nops
                }
                
               // System.out.println("rs " + characters.get(1)+ " rd " + characters.get(2)+ " rt " + characters.get(3));
                if(rs.equalsIgnoreCase(characters.get(2)) || rs.equalsIgnoreCase(characters.get(3))){//Revisar si el siguiente operando (rt, rd) es igual
                    //System.out.println("Insertar 2 nops. Operando");
                    if(nops < 2)
                        nops = 2; //insert 3 nops
                }
                
            } 
            
            if(i + 3 < size){
                characters = instructionsCharacters.get(i + 3);
                if(rs.equalsIgnoreCase(characters.get(1))){//Revisar si el siguiente destino (rs) es igual
                    //System.out.println("Insertar 2 nops");
                    nops = 2; //insert 2 nops
                }
                
                if(rs.equalsIgnoreCase(characters.get(2)) || rs.equalsIgnoreCase(characters.get(3))){//Revisar si el siguiente operando (rt, rd) es igual
                    //System.out.println("Insertar 1 nops. Operando");
                    if(nops < 1)
                        nops = 1; //insert 3 nops
                }
            }
            
            
            instructionsCorrected.add(instructions.get(i));
            if(nops > 0)
                for (int j = 0; j < nops; j++) 
                    instructionsCorrected.add("nop");
                
            
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
        switch (mnemonic) {
            case "add"://Type I or R
            case "addi":
            case "add.d":
            case "sub.d":
            case "xor":
            case "xor.d":
                if (instruction.contains("#")) {//type I
                    rs = parts[1].replace(",", "");
                    rt = parts[2].replace(",", "");
                } else {//type R
                    rs = parts[1].replace(",", "");
                    rt = parts[2].replace(",", "");
                    rd = parts[3];
                }
                break;
            case "movi"://Type I
            case "mov"://Type I
            case "mov.d":
                rs = parts[1].replace(",", "");
                break;
            case "ror.d"://Type I
            case "rol.d":
            case "lsl.d":
            case "lsr.d":
                rs = parts[1].replace(",", "");
                rt = parts[2].replace(",", "");
                break;
            case "cmp"://Type I
                rs = parts[1].replace(",", "");
                break;
            case "load"://Type R
            case "load.d":
            case "store":
            case "store.d":
                rs = parts[1].replace(",", "");
                rt = parts[2];
                break;
            default:
             //   System.out.println("Instruction characters default");
                System.out.println("The wrong mnemonic is: " + mnemonic);
                break;
        }

        //System.out.println("rs: " + rs);
        //System.out.println("rt: " + rt);
        //System.out.println("rd: " + rd);
        
        characters.add(mnemonic);
        characters.add(rs);
        characters.add(rt);
        characters.add(rd);
        
        return characters;
    }
}
