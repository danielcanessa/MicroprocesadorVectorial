/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package proyecto1;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;

/**
 *
 * @author leoam
 */
public class Ensamblador {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) throws FileNotFoundException, IOException {
       ArrayList<String> instructions = new ArrayList<String>();
        Ensamblador ensamblador = new Ensamblador();
        instructions = ensamblador.readFile();
        PrintWriter file = new PrintWriter("binary.txt", "UTF-8");



        ensamblador.ensamblador(instructions, file);
        file.close();
     //   System.out.println(getBinary(5));
      
    }
    
    public String getmNemonic(String mNemonic)
    {
        if (mNemonic.contains("add")) {
            return("00001");
            
        }
        else if(mNemonic.contains("add.d"))
        {
            return("00010");            
        }
        else if(mNemonic.contains("mov"))
        {
            return("00011");            
        }
        else if(mNemonic.contains("mov.d"))
        {
            return("00100");            
        }
        else if(mNemonic.contains("xor"))
        {
            return("00101");            
        }
        else if(mNemonic.contains("xor.d"))
        {
            return("00110");            
        }
        else if(mNemonic.contains("ror.d"))
        {
            return("00111");            
        }
        else if(mNemonic.contains("rol.d"))
        {
            return("01000");            
        }
        else if(mNemonic.contains("lsl.d"))
        {
            return("01001");            
        }
        else if(mNemonic.contains("lsr.d"))
        {
            return("01010");            
        }
        else if(mNemonic.contains("stall")) //tofix
        {
            return("00000");            
        }
        else if(mNemonic.contains("cmp"))
        {
            return("01011");            
        }
        else if(mNemonic.contains("beq"))
        {
            return("01100");            
        }
        else if(mNemonic.contains("load"))
        {
            return("01101");            
        }
        else if(mNemonic.contains("load.d"))
        {
            return("01110");            
        }
        else if(mNemonic.contains("store"))
        {
            return("01111");            
        }
        else if(mNemonic.contains("store.d"))
        {
            return("10000");            
        }
        //10001
        else if(mNemonic.contains("sub.d"))
        {
            return("10001");            
        }
        else
        {
            return "Error al leer el mnemonic";
        }
       
        
        
    }
    public  String getRegister(String register)
    {
        if (register.contains("r1")) {
            return("00000");
            
        }
        else if(register.contains("r2"))
        {
            return("00001");
            
        }
        else if(register.contains("r3"))
        {
            return("00010");
            
        }
        else if(register.contains("r4"))
        {
            return("00011");
            
        }
        else if(register.contains("r5"))
        {
            return("00100");
            
        }
        else if(register.contains("r6"))
        {
            return("00101");
            
        }
        else if(register.contains("r7"))
        {
            return("00110");
            
        }
        else if(register.contains("r8"))
        {
            return("00111");
            
        }
        else if(register.contains("r9"))
        {
            return("01000");
            
        }
        else if(register.contains("r10"))
        {
            return("01001");
            
        }
        else if(register.contains("r11"))
        {
            return("01010");
            
        }
        else if(register.contains("r12"))
        {
            return("01011");
            
        }
        else if(register.contains("r13"))
        {
            return("01100");
            
        }
        else if(register.contains("r14"))
        {
            return("01101");
            
        }
        else if(register.contains("r15"))
        {
            return("01110");
            
        }
        else if(register.contains("r16"))
        {
            return("01111");
            
        }
        else if(register.contains("r17"))
        {
            return("10000");
            
        }
        else if(register.contains("r18"))
        {
            return("10001");
            
        }
        else if(register.contains("r19"))
        {
            return("10010");
            
        }
        else if(register.contains("r20"))
        {
            return("10011");
            
        }
        else if(register.contains("r21"))
        {
            return("10100");
            
        }
        else if(register.contains("r22"))
        {
            return("10101");
            
        }
        else if(register.contains("r23"))
        {
            
            return("10110");
        }
        else if(register.contains("r24"))
        {
            return("10111");
            
        }
        else if(register.contains("r25"))
        {
            return("11000");
            
        }
        else if(register.contains("r26"))
        {
            return("11001");
            
        }
        else if(register.contains("r27"))
        {
            return("11010");
            
        }
        else if(register.contains("r28"))
        {
            return("11011");
            
        }
        else if(register.contains("r29"))
        {
            return("11100");
            
        }
        else if(register.contains("r30"))
        {
            return("11101");
            
        }
        else if(register.contains("r31"))
        {
            return("11110");
            
        }
        else if(register.contains("r32"))
        {
            return("11111");
            
        }
        else 
        {
            return "hay algun error en la lectura de registros";
            
        }
        
    }
    
    public String getBinary(int n)
    {
        String binary=Integer.toBinaryString(n);
        String aux="";
        if (binary.length()<17) {
            for (int i = 0; i < 17-binary.length(); i++) {
                aux+="0";             
            }
            
            
        }
        aux+=binary;
        return aux;
    }
    
     
    public String getBinaryShamt(int n)
    {
        String binary=Integer.toBinaryString(n);
        String aux="";
        if (binary.length()<12) {
            for (int i = 0; i < 12-binary.length(); i++) {
                aux+="0";             
            }           
        }
        aux+=binary;
        return aux;
    }
    
    public String getBinaryAdress(int n)
    {
        String binary=Integer.toBinaryString(n);
        String aux="";
        if (binary.length()<27) {
            for (int i = 0; i < 27-binary.length(); i++) {
                aux+="0";             
            }
            
            
        }
        aux+=binary;
        return aux;
    }
    
    
    public void ensamblador(ArrayList<String> instructions, PrintWriter file){
        ArrayList<String> assembly = new ArrayList<String>();
        String instruction, mnemonic = "", rs = "", rt = "", rd = "", imm = "", addr = "", shamt="";
        String[] parts;
        
        for(int i = 0; i < instructions.size(); i++){
            instruction = instructions.get(i);
            System.out.println("instruccion " + i + " " + instruction);

            parts = instruction.split(" ");
            mnemonic = parts[0];
            rs = "";
            rt = "";
            rd = "";
            imm = "";
            addr = "";
            shamt="";
            switch (mnemonic){
                case "add"://Type I or R
                case "add.d":
                case "sub.d":
                case "xor":
                case "xor.d":
                    if(instruction.contains("#")){//type I
                        rs = parts[1].replace(",", "");
                        rt = parts[2].replace(",", "");
                        imm = parts[3].replace("#", "");
                        
                        file.println(getmNemonic(mnemonic)+getRegister(rs)+getRegister(rt)
                                +getBinary(Integer.parseInt((imm))));
                        
                        System.out.println(getmNemonic(mnemonic)+getRegister(rs)+getRegister(rt)
                                +getBinary(Integer.parseInt((imm))));
                        
                       // getRegister(rt);
                    //getBinary(i)
                      //  getmNemonic(mnemonic);
                      
                    }else{//type R
                        rs = parts[1].replace(",", "");
                        rt = parts[2].replace(",", "");
                        rd = parts[3];
                        
                        file.println(getmNemonic(mnemonic)+getRegister(rs)+getRegister(rt)+getRegister(rd)
                                +"000000000000");
                        
                         System.out.println(getmNemonic(mnemonic)+getRegister(rs)+getRegister(rt)+getRegister(rd)
                                +"000000000000");
                    }
                    break;
                case "mov"://Type I
                case "mov.d":
                    rs = parts[1].replace(",", "");
                    imm = parts[2].replace("#", "");
                    
                    file.println(getmNemonic(mnemonic)+getRegister(rs)+"00000"
                                +getBinary(Integer.parseInt((imm))));
                    System.out.println(getmNemonic(mnemonic)+getRegister(rs)+"00000"
                                +getBinary(Integer.parseInt((imm))));
                    break;
                case "ror.d"://Type I
                case "rol.d":
                case "lsl.d":
                case "lsr.d":
                    rs = parts[1].replace(",", "");
                    rt = parts[2].replace(",", "");
                    shamt = parts[3].replace("#", "");                    
                    file.println(getmNemonic(mnemonic)+getRegister(rs)+getRegister(rt)+"00000"
                                +getBinaryShamt(Integer.parseInt((shamt))));
                    System.out.println(getmNemonic(mnemonic)+getRegister(rs)+getRegister(rt)+"00000"
                                +getBinaryShamt(Integer.parseInt((shamt))));
                    break;
                case "cmp"://Type I
                    rs = parts[1].replace(",", "");
                    imm = parts[2].replace("#", "");
                    
                    file.println(getmNemonic(mnemonic)+getRegister(rs)+"00000"
                                +getBinary(Integer.parseInt((imm))));
                    System.out.println(getmNemonic(mnemonic)+getRegister(rs)+"00000"
                                +getBinary(Integer.parseInt((imm))));
                    break;
                case "beq"://Type B
                    addr = parts[1];
                    addr=addr.replace("#","");
                    file.println(getmNemonic(mnemonic)+getBinaryAdress(Integer.parseInt((addr))));
                    System.out.println(getmNemonic(mnemonic)+getBinaryAdress(Integer.parseInt((addr))));
                    break;
                case "load"://Type R
                case "load.d":
                case "store":
                case "store.d":
                    rs = parts[1].replace(",", "");
                    rt = parts[2];
                    file.println(getmNemonic(mnemonic)+getRegister(rs)+getRegister(rt)+"00000"
                                +"000000000000");
                    System.out.println(getmNemonic(mnemonic)+getRegister(rs)+getRegister(rt)+"00000"
                                +"000000000000");
                    break;
                case "stall":
                    file.println("00000000000000000000000000000000");
                    System.out.println("00000000000000000000000000000000");
                default: 
                        System.out.println("Instruction default");
                        break;
            }
            
            System.out.println("rs: " + rs);
            System.out.println("rt: " + rt);
            System.out.println("rd: " + rd);
            System.out.println("imm: " + imm);
            System.out.println("addr: " + addr);
        }

    }
    
    public ArrayList<String> readFile() throws UnsupportedEncodingException, FileNotFoundException, IOException{
        String line;
        ArrayList<String> instructions = new ArrayList<String>();
        File file = new File("instructions.txt");
        BufferedReader in = new BufferedReader(
                new InputStreamReader(new FileInputStream(file), "UTF8"));

        while ((line = in.readLine()) != null) {
            instructions.add(line);
        }
        in.close();
        return instructions;
    }

}
