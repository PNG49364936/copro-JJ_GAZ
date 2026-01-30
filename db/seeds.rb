# Données de consommation gaz SDC Jean Jaurès

Facture.destroy_all

# 2024/2025
donnees_2024_2025 = [
  { periode: "octobre", consommation_m3: 1181, montant_ht: 811, montant_ttc: 2202 },
  { periode: "novembre", consommation_m3: 5469, montant_ht: 3818, montant_ttc: 8304 },
  { periode: "decembre", consommation_m3: 7177, montant_ht: 5100, montant_ttc: 10849 },
  { periode: "janvier", consommation_m3: 8039, montant_ht: 5733, montant_ttc: 12375 },
  { periode: "fevrier", consommation_m3: 6376, montant_ht: 4565, montant_ttc: 9236 },
  { periode: "mars", consommation_m3: 4733, montant_ht: 3363, montant_ttc: 7284 },
  { periode: "avril", consommation_m3: 1791, montant_ht: 1251, montant_ttc: 3197 }
]

donnees_2024_2025.each do |data|
  Facture.create!(
    periode_budgetaire: "2024_2025",
    periode: data[:periode],
    consommation_m3: data[:consommation_m3],
    montant_ht: data[:montant_ht],
    montant_ttc: data[:montant_ttc]
  )
end

# 2025/2026
donnees_2025_2026 = [
  { periode: "octobre", consommation_m3: 1717, montant_ht: 1096, montant_ttc: 3070 },
  { periode: "novembre", consommation_m3: 4327, montant_ht: 2809, montant_ttc: 6599 },
  { periode: "decembre", consommation_m3: 6507, montant_ht: 4253, montant_ttc: 9692 }
]

donnees_2025_2026.each do |data|
  Facture.create!(
    periode_budgetaire: "2025_2026",
    periode: data[:periode],
    consommation_m3: data[:consommation_m3],
    montant_ht: data[:montant_ht],
    montant_ttc: data[:montant_ttc]
  )
end

puts "#{Facture.count} factures créées"
