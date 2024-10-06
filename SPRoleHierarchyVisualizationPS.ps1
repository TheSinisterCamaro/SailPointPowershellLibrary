# Assuming role data is available in a CSV or via an API
# Import role hierarchy data
$roles = Import-Csv -Path "C:\RoleHierarchy.csv"

# Initialize an array for graph edges
$edges = @()

foreach ($role in $roles) {
    # Add parent-child relationships
    if ($role.ParentRole -ne "") {
        $edges += "$($role.ParentRole) -> $($role.RoleName);"
    }
}

# Create DOT graph
$dotGraph = @"
digraph RoleHierarchy {
    node [shape=box];
    $($edges -join "`n")
}
"@

# Output DOT graph to a file
$dotGraph | Out-File -FilePath "C:\RoleHierarchy.dot"

# Optionally, use Graphviz to generate a visual diagram
# Ensure Graphviz is installed and in the system path
& dot -Tpng C:\RoleHierarchy.dot -o C:\RoleHierarchy.png

# Output the result
Write-Host "Role hierarchy visualization generated at C:\RoleHierarchy.png"
