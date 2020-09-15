#################### COMPILADOR MIPS 32 BITS ####################
# coding=utf-8

import os
import sys
from termcolor import colored

orig_path = os.getcwd()
dict_path = "dictionary"

retval = os.getcwd()
print("Current working directory %s" % retval)

opR = {}
opI_imm = {}
opI_off = {}
opJ = {}
reg = {}
fntc = {}
address = {}
opArithmeticImmediate = {}
codeTemp = []

# Diccionarios
dictArit_Imed = "dictionaryArit_Imed.txt"
dictFunct = "dictionaryFunct.txt"
dictI_Imed = "dictionaryI_Immediate.txt"
dictI_Offset = "dictionaryI_Offset.txt"
dictJ = "dictionaryJ.txt"
dictR = "dictionaryR.txt"
dictReg = "dictionaryReg.txt"

# Archivos
print(sys.argv[1])

mips_file = sys.argv[1]
bin_file = sys.argv[2]

def dec2bin(n):
    if n < 0:
        string = format(n & 0xffff, '16b')
    else:
        string = bin(int(n))[2:].zfill(16)
    return string

def loadDictionaries():
    os.chdir(dict_path)

    with open(dictR) as r:
        for line in r:
            (key, val) = line.split()
            opR[key] = val

    with open(dictI_Offset) as i:
        for line in i:
            (key, val) = line.split()
            opI_off[key] = val

    with open(dictI_Imed) as i:
        for line in i:
            (key, val) = line.split()
            opI_imm[key] = val

    with open(dictJ) as j:
        for line in j:
            (key, val) = line.split()
            #print(val)
            opJ[key] = val

    with open(dictReg) as r:
        for line in r:
            (key, val) = line.split()
            reg[str(key)] = val

    with open(dictFunct) as f:
        for line in f:
            (key, val) = line.split()
            fntc[str(key)] = val

    with open(dictArit_Imed) as a:
        for line in a:
            (key, val) = line.split()
            opArithmeticImmediate[str(key)] = val
    os.chdir(orig_path)

   

# Operaciones R
def instruction_R(line):
    # Operaciones de shift de bits
    opcode = opR[line[0]]
    if line[0] in ['sll', 'srl', 'sra']:
        rs = '00000'
        rt = reg[line[2]]
        rd = reg[line[1]]
        shamt = bin(line[3])[2:].zfill(5)
        funct = fntc(line[0])
        binary = opcode + rs + rt + rd + shamt + funct
    elif line[0] == 'jr':
        rs = reg[line[1]]
        rt = '00000'
        rd = '00000'
        shamt = '00000'
        funct = fntc[line[0]]
        binary = opcode + rs + rt + rd + shamt + funct
    else:
        rs = reg[line[2]]
        rt = reg[line[3]]
        rd = reg[line[1]]
        shamt = '00000'
        funct = fntc[line[0]]
        binary = opcode + rs + rt + rd + shamt + funct
    
    print( colored(opcode, 'red') + " " + 
            colored(rs, 'blue')   + " " +
            colored(rt,'green')   + " " +
            colored(rd,'yellow')  + " " +
            colored(shamt, 'white') + " " +
            colored(funct,'magenta'))
    output.write(binary)
    output.write('\n')

# Operaciones I
def instruction_I(line, type):
    if type == "imm":
        opcode = opI_imm[line[0]]
        rs = reg[line[2]]
        rt = reg[line[1]]
        n = int(line[3])
        if n<0:
            immoff = format(n & 0xffff, '16b')
        else:
            immoff =  bin(int(line[3]))[2:].zfill(16)
    else:
        opcode = opI_off[line[0]]
        rt = reg[line[1]]
        immoff =  bin(int(line[2]))[2:].zfill(16)
        rs = reg[line[3]]
        
    print( colored(opcode, 'red') + " " + 
            colored(rs, 'blue')   + " " +
            colored(rt,'green')   + " " +
            colored(immoff,'yellow'))
    binary = opcode+rs+rt+immoff
    output.write(binary)
    output.write('\n')

# Operaciones aritmeticas inmediatas
def instruction_AritI(line):
    opcode = opArithmeticImmediate[line[0]]
    rs = reg[line[1]]
    rt = reg[line[2]]
    immoff = 0
    if line[0] in ['beq', 'bne']:
        immoff = address[line[3]].zfill(16)
        binary = opcode + rs + rt + immoff
    else:
        x = int(line[3])
        immoff = bin(int(x))[2:].zfill(16)
        binary = opcode + rs + rt + immoff

    print( colored(opcode, 'red') + " " + 
            colored(rs, 'blue')   + " " +
            colored(rt,'green')   + " " +
            colored(immoff,'yellow'))
    output.write(binary)
    output.write('\n')

# Operaciones tipo J
def instruction_J(line):
    opcode = opJ[line[0]]
    if(len(line) > 1):
    	target_address = (address[line[1]]).zfill(26)
    else:
    	target_address = '00000000000000000000000000'	
    binary = opcode + target_address
    print( colored(opcode, 'red') + " " + 
            colored(target_address, 'blue'))
    output.write(binary)
    output.write('\n')

loadDictionaries()

contR=0
contI=0
contJ=0


# Lee el código MIPS y lo traduce a código binary
with open(mips_file,"r") as c:

    numline = 1
    for line in c:
        # Comprueba si la línea es un comentario, si es así, ignora
        if line[0][0] == '#':
            continue
        # Comprueba si la línea esta vacía, si es así, ignora
        if len(line) == 0:
            continue

        #print("linebefore={0}".format(line))

        # Intercambie comas y paréntesis por un espacio y divídalos para obtener una lista
        line = line.replace(',',' ').replace('(',' ').replace(')',' ').split()

        #print(line)

        cont = 0
        for word in line:
            # Remover los comentarios de código
            if(word[0] == '#'):
                while len(line) != cont:
                    del line[cont] 
            cont += 1
            # Buscar la dirección de las etiquetas
            if(word[-1] == ':'):
                word = word.replace(':', '')
                address[word] = bin(numline)[2:]
                del(line[0])
                #print(printBit(numline))
        numline += 1

        # Comprueba si la línea esta vacía, si es así, ignora
        #if len(line) == 1:
         #continue
        codeTemp.append(line)

    # Crea un archivo que recibirá el código binary
    output = open("../TP4_MIPS_V2/TP4_MIPS.srcs/sources_1/imports/mem_init_files/" + bin_file, "w+")

    for line in codeTemp:
        print(line)
        # Instrucción de tipo R
        if line[0] in opR: 
            instruction_R(line)
            contR+=1
        # Instrucción de tipo I immediate
        elif line[0] in opI_imm:
            instruction_I(line, "imm")
            contI+=1
        # Instrucción de tipo I offset
        elif line[0] in opI_off:
            instruction_I(line, "off")
            contI+=1
        # Instrucción de tipo J
        elif line[0] in opJ: 
            instruction_J(line)
            contJ+=1
        # Instrucción de tipo aritmética inmediata
        elif line[0] in opArithmeticImmediate: 
            instruction_AritI(line)
            contR+=1

print("contR:", contR)
print("contI:", contI)
print("contJ:", contJ)
print("total:", contR+contJ+contI)