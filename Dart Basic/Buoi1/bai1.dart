void main() {
   
    int basicSalary = 12000;
    double dA = 0.12 * basicSalary;
    
    int hRA = 150;
    int tA = 120;
    int others = 450;
    
    double iT = 0.15 * basicSalary;
    double pF = 0.14 * basicSalary;
    double netSalary = basicSalary + dA + hRA + tA + others - (pF + iT);
    
    print(netSalary);
}