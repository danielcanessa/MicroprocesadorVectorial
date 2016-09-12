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
import java.util.List;

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
       ArrayList<String> instructionsCorrected = new ArrayList<String>();
       List<List<String>> hashTableLabels= new ArrayList<>();
        Ensamblador ensamblador = new Ensamblador();
        instructions = ensamblador.readFile();
        PrintWriter file = new PrintWriter("binary.txt", "UTF-8");

        RiskDetection riskDetection = new RiskDetection();
        instructionsCorrected = riskDetection.principal(instructions);
       // ensamblador.printInstructions(instructionsCorrected);
        System.out.println("---------------------------------------");
        ensamblador.fillLabels(hashTableLabels,instructionsCorrected);
        ensamblador.ensamblador(instructionsCorrected, file,hashTableLabels);
        file.close();
    }
    
    public void fillLabels(List<List<String>> hashTableLabels,ArrayList<String> instructions)
    {
        int pcCounter=0;
        String  mnemonic = "";
        String[] parts;
       
        for(int i = 0; i < instructions.size(); i++){
            String instruction = instructions.get(i);
            //System.out.println("instruccion " + i + " " + instruction);
            parts = instruction.split(" ");
            mnemonic = parts[0];
            switch (mnemonic)
            {
                case "add"://Type I or R
                case "add.v":
                case "addi":
                case "sub.v":
                case "xor":
                case "xori.v":               
                case "mov"://Type I               
                case "movi"://Type I                
                case "mov.v":                
                case "ror.v"://Type I
                case "rol.v":
                case "lsl.v":
                case "lsr.v":               
                case "beq"://Type B                
                case "load"://Type R
                case "load.v":                   
                case "store":
                case "store.v":                
                case "nop":
                    break;
                default: 
                       // System.out.println(pcCounter+" "+instruction);
                        List<String> aux = new ArrayList<>();
                        aux.add(instruction);
                        aux.add(Integer.toString(pcCounter));
                        hashTableLabels.add(aux);
                        pcCounter=pcCounter-4;
                        break;
            }  
            pcCounter+=4;
    
}
    
        
    }
    public int findLabel(String label,List<List<String>> hashTableLabels) {
        //System.out.println(label);

        int out = -1;

        for (int i = 0; i < hashTableLabels.size(); i++) {
            if (hashTableLabels.get(i).get(0).equals(label)) {
                out = Integer.parseInt(hashTableLabels.get(i).get(1));
            }
        }
       
        return out;

    }
    
    public void printInstructions(ArrayList<String> instructions){
        System.out.println("------- Instructions printed -------");
        for(int i = 0; i<instructions.size(); i++)
            System.out.println(instructions.get(i));
    }
    
    
    public String getmNemonic(String mNemonic)
    {
        if (mNemonic.contains("addi")) {
            return("10011");
            
        }   
        else if(mNemonic.contains("add.v"))
        {
            return("00010");            
        }
        else if(mNemonic.contains("add"))
        {
            return("00001");            
        }
        else if(mNemonic.contains("movi"))
        {
            return("00011");            
        }
        else if(mNemonic.contains("mov.v"))
        {
            return("00100");            
        }
        else if(mNemonic.contains("mov"))
        {
            return("10010");            
        } 
        else if(mNemonic.contains("xori.v"))
        {
            return("00110");            
        }
        else if(mNemonic.contains("xor"))
        {
            return("00101");            
        }        
        else if(mNemonic.contains("ror.v"))
        {
            return("00111");            
        }
        else if(mNemonic.contains("rol.v"))
        {
            return("01000");            
        }
        else if(mNemonic.contains("lsl.v"))
        {
            return("01001");            
        }
        else if(mNemonic.contains("lsr.v"))
        {
            return("01010");            
        }
        else if(mNemonic.contains("nop")) //tofix
        {
            return("00000");            
        }    
        else if(mNemonic.contains("beq"))
        {
            return("01100");            
        }
        else if(mNemonic.contains("load.v"))
        {
            return("01110");            
        }
        else if(mNemonic.contains("load"))
        {
            return("01101");            
        } 
        else if(mNemonic.contains("store.v"))
        {
            return("10000");            
        }
        else if(mNemonic.contains("store"))
        {
            return("01111");            
        }
        
        //10001
        else if(mNemonic.contains("sub.v"))
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
        if (register.contains("r0")) {
          
            return("00000");
            
        }
        else if(register.contains("r2"))
        {
            return("00010");
            
        }
        else if(register.contains("r3"))
        {
            return("00011");
            
        }
        else if(register.contains("r4"))
        {
            return("00100");
            
        }
        else if(register.contains("r5"))
        {
            return("00101");
            
        }
        else if(register.contains("r6"))
        {
            return("00110");
            
        }
        else if(register.contains("r7"))
        {
            return("00111");
            
        }
        else if(register.contains("r8"))
        {
            return("01000");
            
        }
        else if(register.contains("r9"))
        {
            return("01001");
            
        }
        else if(register.contains("r10"))
        {
            return("01010");
            
        }
        else if(register.contains("r11"))
        {
            return("01011");
            
        }
        else if(register.contains("r12"))
        {
            return("01100");
            
        }
        else if(register.contains("r13"))
        {
            return("01101");
            
        }
        else if(register.contains("r14"))
        {
            return("01110");
            
        }
        else if(register.contains("r15"))
        {
            return("01111");
            
        }
         else if(register.contains("r1"))
        {
            return("00001");
            
        }
        else if(register.contains("v0"))
        {
            return("10000");
            
        }
       
        else if(register.contains("v2"))
        {
            return("10010");
            
        }
        else if(register.contains("v3"))
        {
            return("10011");
            
        }
        else if(register.contains("v4"))
        {
            return("10100");
            
        }
        else if(register.contains("v5"))
        {
            return("10101");
            
        }
        else if(register.contains("v6"))
        {
            
            return("10110");
        }
        else if(register.contains("v7"))
        {
            return("10111");
            
        }
        else if(register.contains("v8"))
        {
            return("11000");
            
        }
        else if(register.contains("v9"))
        {
            return("11001");
            
        }
        else if(register.contains("v10"))
        {
            return("11010");
            
        }
        else if(register.contains("v11"))
        {
            return("11011");
            
        }
        else if(register.contains("v12"))
        {
            return("11100");
            
        }
        else if(register.contains("v13"))
        {
            return("11101");
            
        }
        else if(register.contains("v14"))
        {
            return("11110");
            
        }
        else if(register.contains("v15"))
        {
            return("11111");
            
        }
         else if(register.contains("v1"))
        {
            return("10001");
            
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
       // System.out.println("viejo shant: "+n);
        n=n%8;
      //  System.out.println("nuevo shamt: "+n);
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
    
    //Address = ( PC_Etiqueta -  (PC_Actual +4 )) /4
    public void ensamblador(ArrayList<String> instructions, PrintWriter file,List<List<String>> hashTableLabels){        
       
        ArrayList<String> assembly = new ArrayList<String>();
        String instruction, mnemonic = "", rs = "", rt = "", rd = "", imm = "", addr = "", shamt="";
        String[] parts;
        boolean label=false;
        int pcCounter=0;
       
        for(int i = 0; i < instructions.size(); i++){
            String binaryCode="6'd"+i+ "  : data_out = {32'b";
           
            
            instruction = instructions.get(i);
            //System.out.println("instruccion " + i + " " + instruction);

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
                case "add.v":
                case "addi":
                case "sub.v":
                case "xor":
                case "xori.v":
                    if(instruction.contains("#")){//type I
                        rs = parts[1].replace(",", "");
                        rt = parts[2].replace(",", "");
                        imm = parts[3].replace("#", "");
                        
                        file.println(getmNemonic(mnemonic)+getRegister(rt)+getRegister(rs)
                                +getBinary(Integer.parseInt((imm))));
                        
                        binaryCode=binaryCode+getmNemonic(mnemonic)+getRegister(rt)+getRegister(rs)
                                +getBinary(Integer.parseInt((imm)));
                        //System.out.println(getmNemonic(mnemonic)+getRegister(rt)+getRegister(rs)
                                //+getBinary(Integer.parseInt((imm))));
                        
                       // getRegister(rt);
                    //getBinary(i)
                      //  getmNemonic(mnemonic);
                      
                    }else{//type R
                        rd = parts[1].replace(",", "");
                        rs = parts[2].replace(",", "");
                        rt = parts[3];
                   //     System.out.println(rs+", "+rt+", "+rd);
                        file.println(getmNemonic(mnemonic)+getRegister(rs)+getRegister(rt)+getRegister(rd)
                                +"000000000000");
                     //   b=r3 a=r2 1=r1
                                
                         binaryCode=binaryCode+getmNemonic(mnemonic)+getRegister(rs)+getRegister(rt)+getRegister(rd)
                                +"000000000000";
                                 //System.out.println(getmNemonic(mnemonic)+getRegister(rs)+getRegister(rt)+getRegister(rd)
                               // +"000000000000");
                    }
                    break;
                 case "mov.v":
                case "mov"://Type I
                    rd = parts[1].replace(",", "");
                    rs = parts[2].replace(",", "");
                    
                    file.println(getmNemonic(mnemonic)+getRegister(rs)+getRegister(rd)+"00000"
                                +"000000000000");
                   // System.out.println(getRegister(rs)+","+getRegister(rd));
                    binaryCode=binaryCode+getmNemonic(mnemonic)+getRegister(rs)+getRegister(rs)+getRegister(rd)
                                +"000000000000";
                    break;
                case "movi"://Type I                
                
                    rt = parts[1].replace(",", "");
                    imm = parts[2].replace("#", "");
                    
                    file.println(getmNemonic(mnemonic)+ "00000" + getRegister(rt)
                                +getBinary(Integer.parseInt((imm))));
                    binaryCode=binaryCode+getmNemonic(mnemonic)+ "00000" + getRegister(rt)
                                +getBinary(Integer.parseInt((imm)));
                   // System.out.println(getmNemonic(mnemonic)+ "00000" + getRegister(rt)
                               // +getBinary(Integer.parseInt((imm))));
                    break;
                case "ror.v"://Type I
                case "rol.v":
                case "lsl.v":
                case "lsr.v":
                    rd = parts[1].replace(",", "");
                    rs = parts[2].replace(",", "");
                    shamt = parts[3].replace("#", "");                    
                    file.println(getmNemonic(mnemonic)+getRegister(rs)+"00000"+getRegister(rd)//XXXXXXXXXXXXXXXXXXXXXXXXXXXx posible error con los registros
                                +getBinaryShamt(Integer.parseInt((shamt))));
                     binaryCode=binaryCode+getmNemonic(mnemonic)+getRegister(rs)+"00000"+getRegister(rd)
                                +getBinaryShamt(Integer.parseInt((shamt)));
                          //   System.out.println(getmNemonic(mnemonic)+getRegister(rs)+getRegister(rt)+"00000"
                           //     +getBinaryShamt(Integer.parseInt((shamt))));
                    break;
                case "beq"://Type I
                    rs = parts[1].replace(",", "");
                    rt = parts[2].replace(",", "");
                    imm = parts[3];
                    
                    
                   /* */
                    //Address = ( PC_Etiqueta -  (PC_Actual +4 )) /4
                    int adresss= (findLabel(imm,hashTableLabels)-(pcCounter+4))/4;
                    
                 //   System.out.println(rs+", "+", "+rt+", "+completeBitsImmediate(findLabel(imm,hashTableLabels))+", "+adresss);
                    
                                        
                  //  System.out.println(findLabel(imm,hashTableLabels)+" "+pcCounter);
                    file.println(getmNemonic(mnemonic)+getRegister(rs)+getRegister(rt)
                                +completeBitsImmediate(adresss));
                    
                     binaryCode=binaryCode+getmNemonic(mnemonic)+getRegister(rs)+getRegister(rt)
                                +completeBitsImmediate(adresss);
                   
                        // System.out.println(getmNemonic(mnemonic)+"00000"+getRegister(rt)
                             //   +getBinary(Integer.parseInt((imm))));
                    break;
            
                case "load"://Type R
                case "load.v":
                    rt = parts[1].replace(",", "");
                    rs = parts[2];
                    file.println(getmNemonic(mnemonic)+getRegister(rs)+getRegister(rt)+"00000"
                                +"000000000000");
                    binaryCode=binaryCode+getmNemonic(mnemonic)+getRegister(rs)+getRegister(rt)+"00000"
                                +"000000000000";
                    break;
                case "store":
                    rt = parts[2].replace(",", "");
                    rs = parts[1];
                    file.println(getmNemonic(mnemonic)+getRegister(rs)+getRegister(rt)+"00000"
                                +"000000000000");
                    binaryCode=binaryCode+getmNemonic(mnemonic)+getRegister(rs)+getRegister(rt)+"00000"
                                +"000000000000";
                 //   System.out.println(getmNemonic(mnemonic)+getRegister(rs)+getRegister(rt)+"00000"
                          //      +"000000000000");
                    break;
                case "store.v":
                    rs = parts[2].replace(",", "");
                    rt = parts[1];
                    file.println(getmNemonic(mnemonic)+getRegister(rs)+getRegister(rt)+"00000"
                                +"000000000000");
                    binaryCode=binaryCode+getmNemonic(mnemonic)+getRegister(rs)+getRegister(rt)+"00000"
                                +"000000000000";
                 //   System.out.println(getmNemonic(mnemonic)+getRegister(rs)+getRegister(rt)+"00000"
                          //      +"000000000000");
                    break;
                case "nop":
                    file.println("00000000000000000000000000000000");
                    binaryCode=binaryCode+"00000000000000000000000000000000";
                           // System.out.println("00000000000000000000000000000000");
                    break;
                default: 
                    label=true;
                   
                       // System.out.println(pcCounter+" "+instruction);
                        //System.out.println("instruction: "+instruction+", "+findLabel(instruction, hashTableLabels));
                    break;
                
                
            }     
           
            if(label==false)
            {
                pcCounter=pcCounter+4;
                binaryCode=binaryCode+"};            //"+instruction;
                System.out.println(binaryCode);
            }
            else
            {
                label=false;
            }
                    
            
        }

    }
    
    public String completeBitsImmediate(int immediate)
    {
        String out="";
        if (immediate!=-1) {
            out=Integer.toBinaryString(immediate);
            if (out.length()>=17) {
              //  System.out.println("Viejo: "+ out);
                out=out.substring(out.length()-17, out.length());
               // System.out.println("Nuevo: "+out);
            }
           // System.out.println(out.length());
            for (int i = out.length(); i < 17; i++) {
                out="0"+out;
            }        
        }
        else
        {
            System.out.println("Error en el beq, no existe el label");
        }
        return out;
    }
    
    public ArrayList<String> readFile() throws UnsupportedEncodingException, FileNotFoundException, IOException{
        String line;
        ArrayList<String> instructions = new ArrayList<String>();
        
        File file = new File("instructions.txt");
        BufferedReader in = new BufferedReader(
                new InputStreamReader(new FileInputStream(file), "UTF8"));

        while ((line = in.readLine()) != null) {
            
            if(line.length() > 1){
                instructions.add(line);
            }
        }
        in.close();
        return instructions;
    }

}
