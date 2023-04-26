function bool = detect_hopf(eigenvalues)
    eigenvalues = arrayfun(@(x) real(x),eigenvalues);
    bools = eigenvalues >= 0;
    bool = any(bools);
end