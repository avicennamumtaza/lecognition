class DiseaseDetail {
  final int id;
  final String name;
  final String desc;
  final String treatment;
  final String prevention;
  final String severity;
  final List<String> symptoms;

  DiseaseDetail({
    required this.id,
    required this.name,
    required this.desc,
    required this.treatment,
    required this.prevention,
    required this.severity,
    required this.symptoms,
  });
}

List<DiseaseDetail> diseaseDetails = [
  DiseaseDetail(
    id: 3,
    name: 'Anthracnose',
    desc: 'Fungal disease that affects mango leaves and fruits.',
    treatment: 'Use fungicides and prune affected areas.',
    prevention: 'Avoid excessive moisture and overcrowding of plants.',
    severity: 'High',
    symptoms: ['Dark spots on leaves', 'Fruit rot', 'Dieback'],
  ),
  DiseaseDetail(
    id: 4,
    name: 'Bacterial Canker',
    desc: 'Bacterial infection causing cankers on branches.',
    treatment: 'Apply copper-based fungicides, prune infected branches.',
    prevention: 'Ensure good drainage, avoid waterlogging.',
    severity: 'Moderate',
    symptoms: ['Oozing from branches', 'Cankers on branches', 'Leaf wilting'],
  ),
  DiseaseDetail(
    id: 5,
    name: 'Cutting Weevil',
    desc: 'Insect infestation causing cuts on branches and fruits.',
    treatment: 'Use insecticides, remove infested branches.',
    prevention: 'Regularly inspect plants for early signs of infestation.',
    severity: 'Moderate',
    symptoms: ['Cuts on branches', 'Damaged fruits', 'Leaf drop'],
  ),
  DiseaseDetail(
    id: 6,
    name: 'Die Back',
    desc: 'A disease causing drying and death of branches.',
    treatment: 'Apply fungicides, remove dead branches.',
    prevention: 'Ensure balanced soil moisture and nutrition.',
    severity: 'High',
    symptoms: ['Branch drying', 'Fruit drop', 'Leaf discoloration'],
  ),
  DiseaseDetail(
    id: 7,
    name: 'Gall Midge',
    desc: 'Insect larvae forming galls on leaves and stems.',
    treatment: 'Use systemic insecticides, remove affected areas.',
    prevention: 'Monitor plants regularly and maintain cleanliness.',
    severity: 'Low',
    symptoms: ['Galls on leaves', 'Leaf curling', 'Stunted growth'],
  ),
  DiseaseDetail(
    id: 8,
    name: 'Powdery Mildew',
    desc: 'Fungal disease causing white powder on leaves.',
    treatment: 'Use sulfur-based fungicides, remove affected leaves.',
    prevention: 'Avoid overhead watering, ensure good air circulation.',
    severity: 'Moderate',
    symptoms: ['White powdery growth', 'Leaf curling', 'Premature leaf drop'],
  ),
  DiseaseDetail(
    id: 2,
    name: 'Sooty Mould',
    desc: 'Black fungal coating on leaves due to pest excretions.',
    treatment: 'Wash leaves with mild soap, control insect population.',
    prevention: 'Prevent pest infestations by using insect repellents.',
    severity: 'Low',
    symptoms: [
      'Black coating on leaves',
      'Reduced photosynthesis',
      'Yellowing leaves'
    ],
  ),
  DiseaseDetail(
    id: 1,
    name: 'Healthy',
    desc: 'A healthy mango plant with no signs of disease.',
    treatment: 'None needed.',
    prevention: 'Regular monitoring and proper care.',
    severity: 'None',
    symptoms: ['Green leaves', 'Healthy growth', 'Fruit production'],
  ),
];
